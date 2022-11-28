// List of simple redirects

// Add subdomains of ccpgames.com and their redirect destinations here
locals {
  redirects = {
    my = "https://www.tesla.com/ownersmanual/modely/is_is/"
  }
}

// REDIRECT DEFINITIONS BELOW - IGNORE IF ONLY ADDING/EDITING/REMOVING REDIRECT

// Cloudflare record
resource "cloudflare_record" "redirect-record" {
  for_each = local.redirects

  zone_id = var.zone_id
  type    = "A"
  name    = each.key
  value   = "1.2.3.4" // Dummy, won't be used due to the redirect page rule
  proxied = true
}

// Page rule to redirect
resource "cloudflare_page_rule" "redirect-rule" {
  for_each = local.redirects

  zone_id = var.zone_id
  target  = format("%s.%s%s", each.key, var.domain, "/*")

  lifecycle { // Ignore because Cloudflare
    ignore_changes = [priority]
  }

  actions {
    forwarding_url {
      url         = each.value
      status_code = "301"
    }
  }
}
