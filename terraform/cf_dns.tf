resource "cloudflare_record" "olafurgcom-cf-pages" {
  zone_id = var.zone_id
  type    = "CNAME"
  name    = "@"
  value   = "olafurg-github-io.pages.dev"
  proxied = true
}

resource "cloudflare_record" "olafurgcom-cf-pages-www" {
  zone_id = var.zone_id
  type    = "CNAME"
  name    = "www"
  value   = "olafurg-github-io.pages.dev"
  proxied = true
}

// DKIM, DMARC, SPF
resource "cloudflare_record" "spf" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "olafurg.com"
  value   = "v=spf1 include:_spf.mx.cloudflare.net ~all"
  proxied = false
}

resource "cloudflare_record" "dkim" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "*._domainkey"
  value   = "v=DKIM1; p="
  proxied = false
}

resource "cloudflare_record" "dmarc" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "_dmarc"
  value   = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s;"
  proxied = false
}

// MX records
resource "cloudflare_record" "mxisaac" {
  zone_id  = var.zone_id
  type     = "MX"
  name     = "olafurg.com"
  value    = "isaac.mx.cloudflare.net"
  priority = 65
  proxied  = false
}

resource "cloudflare_record" "mxlinda" {
  zone_id  = var.zone_id
  type     = "MX"
  name     = "olafurg.com"
  value    = "linda.mx.cloudflare.net"
  priority = 2
  proxied  = false
}

resource "cloudflare_record" "mxamir" {
  zone_id  = var.zone_id
  type     = "MX"
  name     = "olafurg.com"
  value    = "amir.mx.cloudflare.net"
  priority = 40
  proxied  = false
}