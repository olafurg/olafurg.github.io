resource "cloudflare_regional_tiered_cache" "cache" {
  zone_id = var.zone_id
  value   = "on"
}