module "nfs_instance_template" {
  count                = var.nfs_server_count
  source               = "terraform-google-modules/vm/google//modules/instance_template"
  name_prefix          = "nfs-server-${count.index}"
  region               = var.region
  project_id           = var.project_id
  startup_script       = file("${path.module}/init_nfs.sh")
  source_image         = "debian-11"
  source_image_project = "debian-cloud"
  subnetwork           = var.subnetwork
  additional_disks = [
    {
      disk_name    = "nfs-disk-${count.index}"
      device_name  = "nfs-disk-${count.index}"
      disk_size_gb = var.disk_size_gb
      disk_type    = "pd-ssd"
      auto_delete  = true
      boot         = false
      device_name  = "nfs-disk"
      disk_labels = {
        "nfs-disk" = "nfs-disk"
      }
    }
  ]
  service_account = {
    email  = module.nfs_service_account.email,
    scopes = []
  }
}

module "nfs_server" {
  count              = var.nfs_server_count
  source             = "terraform-google-modules/vm/google//modules/compute_instance"
  subnetwork_project = var.project_id
  subnetwork         = var.subnetwork
  num_instances      = 1
  hostname           = "${var.cluster_name}-nfs-server"
  instance_template  = module.nfs_instance_template.self_link
  region             = var.region
  static_ips         = [var.static_ips[count.index]]
}