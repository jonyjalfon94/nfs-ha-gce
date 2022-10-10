# Define GCS backend configuration 
terraform {
  backend "gcs" {
    bucket = "playground-s-11-d2896fc3"
    prefix = "terraform/state"
  }
}