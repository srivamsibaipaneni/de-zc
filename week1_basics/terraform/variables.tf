variable "project" {
  description = "project name"
  default     = "learn-terraform-412005"
}

variable "region" {
  description = "setting up default region for my project"
  default     = "us-east1"
}

variable "service_acc_credentials" {
  description = "my service account credentials"
  default     = "./keys/key-creds.json"
}

variable "vm_name" {
  description = "my vm name"
  default     = "de-zoomcamp"
}