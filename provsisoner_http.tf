terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
  }
}
provider "http" {
  # Configuration options
}

data "http" "example" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  # Optional request headers
  request_headers = {
    Accept = "application/html"
  }
}
