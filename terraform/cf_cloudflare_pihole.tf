resource "cloudflare_record" "pihole" {
  zone_id = var.zone_id
  type    = "A"
  name    = "pihole"
  value   = "153.92.153.150"
  proxied = true // hides the IP address destination
}