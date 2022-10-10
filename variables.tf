variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "cluster_name" {
  description = "The name for the GKE cluster"
  default     = "demo"
}

variable "region" {
  description = "The region to host the cluster in"
  default     = "us-central1"
}

variable "subnetwork" {
  description = "The subnetwork created to host the cluster in"
  default     = "demo-subnet"
}