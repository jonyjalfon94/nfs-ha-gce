# # google_client_config and kubernetes provider must be explicitly specified like the following.
# data "google_client_config" "default" {}

provider "google" {
  project = "playground-s-11-f31135a1"
  region  = "us-central1"
}