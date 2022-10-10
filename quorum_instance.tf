module "quorum_instance_template" {
  source               = "terraform-google-modules/vm/google//modules/instance_template"
  name_prefix          = "quorum"
  region               = var.region
  project_id           = var.project_id
  startup_script       = file("${path.module}/init_quorum.sh")
  source_image         = "debian-11"
  source_image_project = "debian-cloud"
  subnetwork           = var.subnetwork
  service_account = {
    email  = module.nfs_service_account.email,
    scopes = []
  }
}

module "quorum_server" {
  source            = "terraform-google-modules/vm/google//modules/umig"
  project_id        = var.project_id
  subnetwork        = var.subnetwork
  num_instances     = 1
  hostname          = "${var.cluster_name}-nfs-quorum"
  instance_template = module.nfs_instance_template.self_link
  region            = var.region
  static_ips        = [var.static_ips[2]]
}