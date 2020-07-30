Single Server with Proxmox and Terraform
----
This is primarily for easily launching new instances on my own Proxmox setup with no special scripts. There are other examples like my Kubernetes one here: https://github.com/travisz/terraform-proxmox-kubernetes

*NOTE*: Please note there are some hard-coded IP addresses and ranges in a few of the scripts. You will want to grep for "192.168.192" and review them as needed.

# Requirements
* Proxmox Terraform Provider: https://github.com/Telmate/terraform-provider-proxmox
* export of `PM_PASS` variable
* Fill out a "vars" file to pass to Terraform.

# Variables
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| clone_name | Name of the template/clone to use for launch instances | string | `` | yes |
| instance_cores | Number of cores to allocate to each VM (default: 2) | number | `2` | no |
| os_disk_size | Amount of disk space to allocate to each VM (default: 10G) | number | `10` | no |
| instance_memory | Amount of memory to allocate to each VM (default: 1024) | number | `1024` | no |
| instance_name | Name of the instance. Used in the name within the Proxmox Interface| string | `` | yes |
| instance_sockets | Number of sockets to allocate to each VM (default: 1) | number | `1` | no |
| instance_storage_name | Name of the storage to use within Proxmox | string | `` | yes |
| instance_storage_type | Type of storage to use within Proxmox | string | `` | yes |
| instance_count | Number of Servers | number | `1` | no |
| private_key_path | Path to your private key to use with the provisioner | string | `` | yes |
| proxmox_node_name | Name of the Proxmox Node to deploy the instances on | string | `` | yes |
| proxmox_url | URL of the Proxmox API | string | `` | yes |
| proxmox_user | Valid user to access the Proxmox API | string | `` | yes |
| ssh_key | SSH Key to associate with the instance | string | `` | yes |

# Example Var File
```text
clone_name = "kubernetes-template"
instance_cores = "2"
instance_disk_size = "20"
instance_memory = "4096"
instance_name = "test"
instance_sockets = "1"
instance_storage_name = "vmdata"
instance_storage_type = "dir"
private_key_path = "/path/to/your/key"
proxmox_node_name = "proxmox01"
proxmox_url = "https://proxmox01.local/api2/json"
proxmox_user = "root@pam"
ssh_key = "ssh-rsa AAAAB3.... user@host"
```

# Issues
* A `lifecycle` block is needed to ignore changes to the "network" section as subsequent applies mess with networking. This is a known issue with the Terraform Proxmox provider: https://github.com/Telmate/terraform-provider-proxmox/issues/112.
