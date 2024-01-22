terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.12.0"
    }
  }
}

provider "google" {
  credentials = "./keys/key-creds.json"
  project     = "learn-terraform-412005"
  region      = "us-east1"
}

resource "google_storage_bucket" "demo-buckek" {
  name          = "learn-terraform-412005-terra-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}