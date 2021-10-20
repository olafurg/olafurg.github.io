terraform {
  backend "remote" {
    organization = "olafurg"
    
    workspaces {
      name = "olafurg"
    }
  }
}