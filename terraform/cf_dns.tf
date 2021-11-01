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

resource "cloudflare_record" "terraform_managed_resource_da78c05dabcd8cb081f0d7643bc3c275" {
  name    = "olafurg.com"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=spf1 include:spf.messagingengine.com"
  zone_id = var.zone_id
}