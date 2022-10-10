locals {
  project_id = "playground-s-11-f31135a1"
  region     = "us-central1"
}


module "nfs_cluster" {
  source       = "../"
  project_id   = local.project_id
  cluster_name = "demo"
  region       = "us-central1"
  subnetwork   = module.gcp_network.subnets_names[0]
  static_ips   = ["10.0.0.4", "10.0.0.5", "10.0.0.6"]
  disk_size_gb = 20
}