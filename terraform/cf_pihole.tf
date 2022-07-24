// DNS
resource "cloudflare_record" "ph" {
  zone_id = var.zone_id
  type    = "A"
  name    = "ph"
  value   = "1.2.3.4"
  proxied = true
}

// Page rule to redirect
resource "cloudflare_page_rule" "pihole-redirect" {
  zone_id = var.zone_id
  target  = "ph.olafurg.com/*"

  lifecycle { // Ignore because Cloudflare
    ignore_changes = [priority]
  }

  actions {
    forwarding_url {
      url         = "https://pihole.olafurg.com/admin"
      status_code = "301"
    }
  }
}
