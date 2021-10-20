terraform { 
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 2.0"
    }
  }
}

provider "cloudflare" {
  # $CLOUDFLARE_EMAIL env variable
  # $CLOUDFLARE_API_TOKEN env variable
}