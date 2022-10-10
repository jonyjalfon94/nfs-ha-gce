locals {
  named_ports = [{
    name = "nfs"
    port = 2049
  }]
  health_check = {
    type                = "tcp"
    check_interval_sec  = 1
    healthy_threshold   = 4
    timeout_sec         = 1
    unhealthy_threshold = 5
    response            = ""
    proxy_header        = "NONE"
    port                = 2049
    port_name           = "nfs"
    enable_log          = false
  }
}

module "gce-ilb" {
  source  = "terraform-google-modules/network/google//modules/internal-load-balancer"
  project = var.project
  region  = var.region
  name    = "nfs-ilb"
  ports   = []
  #   source_tags  = ["allow-group1"]
  #   target_tags  = ["allow-group2", "allow-group3"]
  health_check = local.health_check

  backends = [
    {
      group       = module.nfs_server.umig_details[0].instance_group
      description = ""
      failover    = false
    },
    {
      group       = module.nfs_server.umig_details[1].instance_group
      description = ""
      failover    = false
    }
  ]
}