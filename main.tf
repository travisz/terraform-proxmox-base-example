# Requires export of PM_PASS
provider "proxmox" {
  pm_api_url  = var.proxmox_url
  pm_user     = var.proxmox_user
  pm_parallel = "8"
}

# Basic Instance in Proxmox
resource "proxmox_vm_qemu" "servers" {
  count       = var.instance_count
  name        = "${var.instance_name}-${count.index}"
  desc        = "${var.instance_name}-${count.index}"
  target_node = var.proxmox_node_name
  clone       = var.clone_name
  agent       = 1
  full_clone  = true
  os_type     = "cloud-init"
  cores       = var.instance_cores
  sockets     = var.instance_sockets
  cpu         = "host"
  memory      = var.instance_memory
  scsihw      = "lsi"
  bootdisk    = "scsi0"

  disk {
    id           = 0
    size         = var.os_disk_size
    type         = "scsi"
    storage      = var.instance_storage_name
    storage_type = var.instance_storage_type
    iothread     = true
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.192.18${count.index}/24,gw=192.168.192.1"

  sshkeys = var.ssh_key
}

# Deploy Server
resource "null_resource" "deploy" {
  count = var.instance_count

  provisioner "file" {
    source      = "scripts/install.sh"
    destination = "/dev/shm/install.sh"

    connection {
      type        = "ssh"
      user        = "debian"
      host        = element(proxmox_vm_qemu.servers.*.ssh_host, count.index)
      private_key = file(var.private_key_path)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /dev/shm/install.sh",
      "/bin/bash /dev/shm/install.sh"
    ]

    connection {
      type        = "ssh"
      user        = "debian"
      host        = element(proxmox_vm_qemu.servers.*.ssh_host, count.index)
      private_key = file(var.private_key_path)
    }
  }
}
