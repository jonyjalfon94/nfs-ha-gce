module "nfs_instance_template" {
  source               = "terraform-google-modules/vm/google//modules/instance_template"
  name_prefix          = "nfs-server"
  region               = var.region
  project_id           = var.project_id
  startup_script       = file("${path.module}/init_nfs.sh")
  source_image         = "debian-11"
  source_image_project = "debian-cloud"
  subnetwork           = var.subnetwork
  disk_size_gb         = var.disk_size_gb
  disk_type            = "pd-ssd"
  service_account = {
    email  = module.nfs_service_account.email,
    scopes = []
  }
}

module "nfs_server" {
  source            = "terraform-google-modules/vm/google//modules/umig"
  project_id        = var.project_id
  subnetwork        = var.subnetwork
  num_instances     = 2
  hostname          = "${var.cluster_name}-nfs-server"
  instance_template = module.nfs_instance_template.self_link
  region            = var.region
  static_ips        = [var.static_ips[0], var.static_ips[1]]
}