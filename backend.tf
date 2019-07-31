terraform {
  backend "gcs" {
    bucket      = "nhyne-terraform"
    prefix      = "state/dns"
    credentials = "~/.keys/nhyne.json"
  }

  required_version = ">= 0.12"
}

