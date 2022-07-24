terraform {
  backend "remote" {
    organization = "olafurg"

    workspaces {
      name = "olafurg"
    }
  }
}

provider "cloudflare" {
  # $CLOUDFLARE_EMAIL env variable
  # $CLOUDFLARE_API_TOKEN env variable
}