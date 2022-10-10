# Terraform Modules Template

Put a short description of what this module does.

<!-- terraform-docs output will go here -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.39.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_nfs_instance_template"></a> [nfs\_instance\_template](#module\_nfs\_instance\_template) | terraform-google-modules/vm/google//modules/instance_template | n/a |
| <a name="module_nfs_server"></a> [nfs\_server](#module\_nfs\_server) | terraform-google-modules/vm/google//modules/compute_instance | n/a |
| <a name="module_nfs_service_account"></a> [nfs\_service\_account](#module\_nfs\_service\_account) | terraform-google-modules/service-accounts/google | n/a |
| <a name="module_quorum_instance_template"></a> [quorum\_instance\_template](#module\_quorum\_instance\_template) | terraform-google-modules/vm/google//modules/instance_template | n/a |
| <a name="module_quorum_server"></a> [quorum\_server](#module\_quorum\_server) | terraform-google-modules/vm/google//modules/compute_instance | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name for the GKE cluster | `string` | `"demo"` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | The size of the disk to attach to the nfs servers | `number` | `10` | no |
| <a name="input_nfs_server_count"></a> [nfs\_server\_count](#input\_nfs\_server\_count) | The number of nfs servers to create | `number` | `2` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to host the cluster in | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in | `string` | `"us-central1"` | no |
| <a name="input_static_ips"></a> [static\_ips](#input\_static\_ips) | The static ips to assign to the nfs server | `list(string)` | n/a | yes |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The subnetwork created to host the cluster in | `string` | `"demo-subnet"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

