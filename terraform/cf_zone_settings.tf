locals {
  zone_settings = {
    always_online            = "off"
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    brotli                   = "on"
    min_tls_version          = "1.2"
    opportunistic_encryption = "on"
    ssl                      = "flexible"
    tls_1_3                  = "on"
  }
}

resource "cloudflare_zone_setting" "settings" {
  for_each = local.zone_settings

  zone_id    = var.zone_id
  setting_id = each.key
  value      = each.value
}
