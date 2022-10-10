module "service_accounts_1" {
  source     = "terraform-google-modules/service-accounts/google"
  project_id = local.project_id
  names      = ["test-instance"]
  # project_roles = ["${local.project_id}=>roles/viewer"]
  display_name = "test-instance"
  description  = "test-instance"
}

module "nfs_instance_template_1" {
  source               = "terraform-google-modules/vm/google//modules/instance_template"
  region               = local.region
  project_id           = local.project_id
  startup_script       = file("${path.module}/test_instance.sh")
  source_image         = "debian-11"
  source_image_project = "debian-cloud"
  subnetwork           = module.gcp_network.subnets_names[0]
  service_account = {
    email  = module.service_accounts_1.email,
    scopes = []
  }
}

module "test_instance" {
  source            = "terraform-google-modules/vm/google//modules/umig"
  project_id        = local.project_id
  subnetwork        = module.gcp_network.subnets_names[0]
  num_instances     = 1
  hostname          = "test-instance"
  instance_template = module.nfs_instance_template_1.self_link
  region            = local.region
}