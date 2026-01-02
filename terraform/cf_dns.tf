resource "cloudflare_dns_record" "olafurgcom-cf-pages" {
  zone_id = var.zone_id
  type    = "CNAME"
  name    = "@"
  content = "olafurg-github-io.pages.dev"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "olafurgcom-cf-pages-www" {
  zone_id = var.zone_id
  type    = "CNAME"
  name    = "www"
  content = "olafurg-github-io.pages.dev"
  proxied = true
  ttl     = 1
}

// DKIM, DMARC, SPF
resource "cloudflare_dns_record" "spf" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "olafurg.com"
  content = "v=spf1 include:_spf.mx.cloudflare.net -all"
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "dkim" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "*._domainkey"
  content = "v=DKIM1; p="
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "dkim_cf" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "cf2024-1._domainkey"
  content = "v=DKIM1; h=sha256; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiweykoi+o48IOGuP7GR3X0MOExCUDY/BCRHoWBnh3rChl7WhdyCxW3jgq1daEjPPqoi7sJvdg5hEQVsgVRQP4DcnQDVjGMbASQtrY4WmB1VebF+RPJB2ECPsEDTpeiI5ZyUAwJaVX7r6bznU67g7LvFq35yIo4sdlmtZGV+i0H4cpYH9+3JJ78km4KXwaf9xUJCWF6nxeD+qG6Fyruw1Qlbds2r85U9dkNDVAS3gioCvELryh1TxKGiVTkg4wqHTyHfWsp7KD3WQHYJn0RyfJJu6YEmL77zonn7p2SRMvTMP3ZEXibnC9gz3nnhR6wcYL8Q7zXypKTMD58bTixDSJwIDAQAB"
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "dmarc" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "_dmarc"
  content = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s; rua=mailto:e366d8b47d304fb1a63cca9477a28994@dmarc-reports.cloudflare.net;"
  proxied = false
  ttl     = 1
}

// MX records
resource "cloudflare_dns_record" "mxisaac" {
  zone_id  = var.zone_id
  type     = "MX"
  name     = "olafurg.com"
  content  = "isaac.mx.cloudflare.net"
  priority = 65
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "mxlinda" {
  zone_id  = var.zone_id
  type     = "MX"
  name     = "olafurg.com"
  content  = "linda.mx.cloudflare.net"
  priority = 2
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "mxamir" {
  zone_id  = var.zone_id
  type     = "MX"
  name     = "olafurg.com"
  content  = "amir.mx.cloudflare.net"
  priority = 40
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "security_contact" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "_security"
  content = "security_contact=https://olafurg.com/security"
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "security_policy" {
  zone_id = var.zone_id
  type    = "TXT"
  name    = "_security"
  content = "security_policy=https://olafurg.com/security"
  proxied = false
  ttl     = 1
}
