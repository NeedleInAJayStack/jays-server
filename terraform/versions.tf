terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "jayherron-terraform"
    key    = "jays-server"
    region = "us-west-2"
  }
}