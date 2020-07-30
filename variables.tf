variable "clone_name" {
  description = "Name of the template/clone to use for launch instances"
  type        = string
}

variable "instance_cores" {
  default     = 2
  description = "Number of cores to allocate to each VM (default: 2)"
  type        = number
}

variable "os_disk_size" {
  default     = 10
  description = "Amount of disk space to allocate to each VM (default: 10G)"
  type        = number
}

variable "instance_memory" {
  default     = 1024
  description = "Amount of memory to allocate to each VM (default: 1024)"
  type        = number
}

variable "instance_name" {
  description = "Name of the instance. Used in the name within the Proxmox Interface"
  type = string
}

variable "instance_sockets" {
  default     = 1
  description = "Number of sockets to allocate to each VM (default: 1)"
  type        = number
}

variable "instance_storage_name" {
  description = "Name of the storage to use within Proxmox"
  type        = string
}

variable "instance_storage_type" {
  description = "Type of storage to use within Proxmox"
  type        = string
}

variable "instance_count" {
  default     = 1
  description = "Number of Servers"
  type        = number
}

variable "private_key_path" {
  description = "Path to your private key to use with the provisioner"
  type        = string
}

variable "proxmox_node_name" {
  description = "Name of the Proxmox Node to deploy the instances on"
  type        = string
}

variable "proxmox_url" {
  description = "URL of the Proxmox API"
  type        = string
}

variable "proxmox_user" {
  description = "Valid user to access the Proxmox API"
  type        = string
}

variable "ssh_key" {
  description = "SSH Key to associate with the instance"
  type        = string
}
