terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.12.0"
    }
  }
}

provider "google" {
  credentials = file(var.service_acc_credentials)
  project     = var.project
  region      = var.region
}

resource "google_compute_instance" "default" {
  name         = var.vm_name
  machine_type = "n1-standard-4"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20220118"
      size  = 30
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}