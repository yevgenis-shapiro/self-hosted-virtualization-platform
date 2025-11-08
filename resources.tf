
terraform {
  required_providers {
    harvester = {
      source  = "harvester/harvester"
      version = "~> 0.6.6" # latest stable
    }
  }
}

provider "harvester" {
  kubeconfig = file("./modules/provider/harvester.yaml")
}

# 1️⃣ Network
resource "harvester_network" "default" {
  name                 = "default"
  namespace            = "default"
  vlan_id              = 1
  cluster_network_name = "mgmt"  # must match an existing Harvester cluster network
}

# 2️⃣ SSH key
resource "harvester_ssh_key" "example" {
  name       = "ubuntu"
  namespace  = "default"
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub")
}

# 3️⃣ Cloud image
resource "harvester_image" "ubuntu" {
  name          = "ubuntu-22"
  namespace     = "default"
  display_name  = "Ubuntu 22.04"
  source_type   = "download"
  url           = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

# 4️⃣ Virtual Machine
resource "harvester_virtualmachine" "vm1" {
  name         = "vm1"
  namespace    = "default"
  description  = "Terraform VM Example"
  run_strategy = "RerunOnFailure"

  cpu    = 2
  memory = "2Gi"

  hostname = "vm1"
  ssh_keys = [harvester_ssh_key.example.name]

  # 🧱 Disk block (singular)
  disk {
    name       = "rootdisk"
    type       = "disk"
    size       = "20Gi"
    image      = harvester_image.ubuntu.id
    boot_order = 1
  }

  # 🌐 Network block (singular)
  network_interface {
    name          = "nic-1"
    network_name  = harvester_network.default.name
  }

  # ☁️ Cloud-init user data
  cloudinit {
    user_data = <<EOF
#cloud-config
hostname: vm1
ssh_authorized_keys:
  - ${harvester_ssh_key.example.public_key}
package_update: true
packages:
  - nginx
runcmd:
  - systemctl enable nginx
  - systemctl start nginx
EOF
  }
}
