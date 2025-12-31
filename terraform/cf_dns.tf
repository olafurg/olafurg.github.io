resource "cloudflare_dns_record" "olafurgcom-cf-pages" {
  zone_id = var.zone_id
  type    = "CNAME"
  name    = "@"
  content = "olafurg-github-io.pages.dev"
  proxied = true
  ttl     = 3600
}

resource "cloudflare_dns_record" "olafurgcom-cf-pages-www" {
  zone_id = var.zone_id
  type    = "CNAME"
  name    = "www"
  content = "olafurg-github-io.pages.dev"
  proxied = true
  ttl     = 3600
}

// DKIM, DMARC, SPF
resource "cloudflare_dns_record" "spf" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "olafurg.com"
  content = "v=spf1 include:_spf.mx.cloudflare.net ~all"
  proxied = false
  ttl     = 3600
}

resource "cloudflare_dns_record" "dkim" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "*._domainkey"
  content = "v=DKIM1; p="
  proxied = false
  ttl     = 3600
}

resource "cloudflare_dns_record" "dmarc" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "_dmarc"
  content = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s;"
  proxied = false
  ttl     = 3600
}

// MX records
resource "cloudflare_dns_record" "mxisaac" {
  zone_id  = var.zone_id
  type     = "MX"
  name     = "olafurg.com"
  content  = "isaac.mx.cloudflare.net"
  priority = 65
  proxied  = false
  ttl      = 3600
}

resource "cloudflare_dns_record" "mxlinda" {
  zone_id  = var.zone_id
  type     = "MX"
  name     = "olafurg.com"
  content  = "linda.mx.cloudflare.net"
  priority = 2
  proxied  = false
  ttl      = 3600
}

resource "cloudflare_dns_record" "mxamir" {
  zone_id  = var.zone_id
  type     = "MX"
  name     = "olafurg.com"
  content  = "amir.mx.cloudflare.net"
  priority = 40
  proxied  = false
  ttl      = 3600
}
