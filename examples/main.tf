module "nfs_cluster" {
  source       = "../"
  project_id   = "playground-s-11-d2896fc3"
  cluster_name = "demo"
  region       = "us-central1"
  subnetwork   = module.gcp_network.network.subnets_names[0]
}