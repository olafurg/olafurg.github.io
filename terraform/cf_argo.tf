resource "cloudflare_argo" "basic" {
  zone_id        = var.zone_id
  tiered_caching = "on"
  smart_routing  = "on"
}