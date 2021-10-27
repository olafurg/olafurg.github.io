resource "cloudflare_record" "terraform_managed_resource_c970b7377cfbd95b357d96d5ff2bfe0f" {
  name    = "olafurg.com"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "138.68.50.15"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_a8ea67bc69dc36f728be1cb28be3bd25" {
  name    = "olafurg.com"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "54.241.68.193"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_f3aedb65365064b333a2f98b2f76dd67" {
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "54.241.246.27"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_40b8efc602a4b8b685ea5f0b0d217050" {
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "138.197.207.178"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_96188378b48d253d70ce1f929d6de9a5" {
  name    = "olafurg.com"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "2600:1f1c:471:9d00:64a9:5908:2245:64e0"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_e4c590497429e9d60230177da3a3bf9d" {
  name    = "olafurg.com"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "2600:1f1c:471:9d00:1478:99ac:4b21:1cba"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_aa642b8efa450b75b727b801425907a5" {
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "2600:1f1c:471:9d00:53b8:d5a3:8371:32f9"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_faa63affcde408c4ec9e111cf228b261" {
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "2600:1f1c:471:9d00:64a9:5908:2245:64e0"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_da78c05dabcd8cb081f0d7643bc3c275" {
  name    = "olafurg.com"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=spf1 include:spf.messagingengine.com"
  zone_id = var.zone_id
}