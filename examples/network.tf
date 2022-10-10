locals {
  project_id = "playground-s-11-d2896fc3"
  region     = "us-central1"
}

module "gcp_network" {
  source  = "terraform-google-modules/network/google"
  version = ">= 4.0.1, < 5.0.0"

  project_id   = local.project_id
  network_name = "demo-network"

  subnets = [
    {
      subnet_name   = "demo-subnet"
      subnet_ip     = "10.0.0.0/17"
      subnet_region = local.region
    },
  ]

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]
}

resource "google_compute_firewall" "allow_ssh" {
  project = local.project_id
  name    = "allow-ssh"
  network = module.gcp_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}

resource "google_compute_firewall" "allow_nfs" {
  project = local.project_id
  name    = "allow-nfs"
  network = module.gcp_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = ["2049"]
  }
  source_ranges = ["192.168.0.0/18, 10.0.0.0/17"]
}

resource "google_compute_router" "router" {
  project = local.project_id
  name    = "nat-router"
  network = module.gcp_network.network.self_link
  region  = local.region
}

module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "v2.2.1"
  project_id                         = local.project_id
  region                             = local.region
  router                             = google_compute_router.router.name
  name                               = "nat-config"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}