# If wiki.olafurg.com (and nothing else)
# Redirect to somewhere else

# If wiki.olafurg.com/display/*
# Don't do anything

resource "cloudflare_ruleset" "redirect_from_list_example" {
  zone_id     = var.zone_id
  name        = "redirects"
  description = "Redirect ruleset"
  kind        = "root"
  phase       = "http_request_redirect"

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
    expression  = "(http.request.uri eq \"\" and http.host eq \"wiki.olafurg.com\")"
    enabled     = true
  }
}