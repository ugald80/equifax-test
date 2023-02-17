terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.53.1" #"3.90.1"
    }
  }
}

provider "google" {
  credentials = file(var.google_credentials_file)
  project = "equifax-test-377917"
  region  = "us-central1"
  zone    = "us-central1-c"
}
data "google_client_config" "current" {
}

data "google_service_account" "myaccount" {
  account_id = data.google_client_config.current.id
}

provider "google-beta" {
  credentials = file(var.google_credentials_file)
  project = "equifax-test-377917"
  region  = "us-central1"
  zone    = "us-central1-c"
}
