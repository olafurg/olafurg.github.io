// Uptime Kuma — exposed via Cloudflare Tunnel with Access protection

// ── DNS record ────────────────────────────────────────────────────────────────
resource "cloudflare_dns_record" "uptime-kuma" {
  zone_id = var.zone_id
  type    = "CNAME"
  name    = "up"
  content = "${var.tunnel_id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

// ── Tunnel public hostname ────────────────────────────────────────────────────
resource "cloudflare_zero_trust_tunnel_cloudflared_config" "uptime-kuma" {
  account_id = var.account_id
  tunnel_id  = var.tunnel_id

  config = {
    ingress = [
      {
        hostname       = "up.${var.domain}"
        service        = "http://10.10.10.200:3001"
        origin_request = {}
      },
      {
        hostname       = "chat.${var.domain}"
        service        = "http://10.10.10.201:8065"
        origin_request = {}
      },
      {
        service = "http_status:404"
      }
    ]
  }
}

// ── WAF: Iceland only ─────────────────────────────────────────────────────────
resource "cloudflare_ruleset" "uptime-kuma-firewall" {
  zone_id     = var.zone_id
  name        = "Uptime Kuma firewall"
  description = "Block non-Iceland traffic to up.olafurg.com"
  kind        = "zone"
  phase       = "http_request_firewall_custom"

  rules = [
    {
      action      = "block"
      description = "Uptime Kuma - Iceland only"
      enabled     = true
      expression  = "(http.host eq \"up.olafurg.com\" and ip.src.country ne \"IS\")"
    }
  ]
}

// ── Cloudflare Access: app + policy fully inline (v5 schema) ─────────────────
resource "cloudflare_zero_trust_access_application" "uptime-kuma" {
  account_id       = var.account_id
  name             = "Uptime Kuma"
  domain           = "up.${var.domain}"
  type             = "self_hosted"
  session_duration = "24h"

  policies = [
    {
      precedence = 1
      decision   = "allow"
      name       = "Allow Óli"
      include = [
        {
          email = {
            email = "olafur.g@gmail.com"
          }
        }
      ]
    }
  ]
}
