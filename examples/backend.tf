# Define GCS backend configuration 
terraform {
  backend "gcs" {
    bucket = "playground-s-11-f31135a1"
    prefix = "terraform/state"
  }
}