resource "cloudflare_zone_settings_override" "terraform_managed_resource_09f360312ef3fb832693832382a84ffc" {
  zone_id = "09f360312ef3fb832693832382a84ffc"
  settings {
    minify {
      css = "on"
      html = "on"
      js = "on"
    }
    always_use_https = "on"
    automatic_https_rewrites = "on"
    brotli = "on"
    min_tls_version = "1.2"
    opportunistic_encryption = "on"
    ssl = "strict"
    tls_1_3 = "on"
  }
}

