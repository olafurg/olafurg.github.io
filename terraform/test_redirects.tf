# If wiki.olafurg.com (and nothing else)
# Redirect to somewhere else

# If wiki.olafurg.com/display/*
# Don't do anything

// Cloudflare record
resource "cloudflare_record" "wiki" {

  zone_id = var.zone_id
  type    = "CNAME"
  name    = "wiki"
  value   = "pihole" // Dummy, won't be used due to the 
  proxied = true
}

resource "cloudflare_ruleset" "redirect_from_list_example" {
  zone_id     = var.zone_id
  name        = "redirects"
  description = "Redirect ruleset"
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  rules {
    action = "redirect"
    action_parameters {
      from_value {
        status_code = 301
        target_url {
          value = "visir.is"
        }
        preserve_query_string = false
      }
    }
    description = "Redirects"
    expression  = "(http.host eq \"wiki.olafurg.com\" and not starts_with(http.request.uri, \"/display\"))"
    enabled     = true
  }
}