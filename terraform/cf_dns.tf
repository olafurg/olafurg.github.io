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
