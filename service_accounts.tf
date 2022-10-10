module "nfs_service_account" {
  source     = "terraform-google-modules/service-accounts/google"
  project_id = var.project_id
  names      = ["nfs-server"]
  # project_roles = ["${var.project_id}=>roles/viewer"]
  display_name = "nfs-server"
  description  = "nfs-server"
}