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

variable "static_ips" {
  type        = list(string)
  description = "The static ips to assign to the nfs server"
}

variable "disk_size_gb" {
  description = "The size of the disk to attach to the nfs servers"
  default     = 10
}

variable "nfs_server_count" {
  description = "The number of nfs servers to create"
  default     = 2
}