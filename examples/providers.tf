# # google_client_config and kubernetes provider must be explicitly specified like the following.
# data "google_client_config" "default" {}

provider "google" {
  project = "playground-s-11-9f32668d"
  region  = "us-central1"
}