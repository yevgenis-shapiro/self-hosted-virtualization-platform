
resource "harvester_network" "default" {
  name      = "default"
  namespace = "default"
  vlan_id   = 1
}

resource "harvester_ssh_key" "example" {
  name      = "example-key"
  namespace = "default"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "harvester_image" "ubuntu" {
  name        = "ubuntu-22"
  namespace   = "default"
  display_name = "Ubuntu 22.04"
  source_type  = "download"
  url          = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

resource "harvester_virtualmachine" "vm1" {
  name       = "vm1"
  namespace  = "default"
  description = "Terraform VM Example"

  run_strategy = "RerunOnFailure"

  cpu    = 2
  memory = "4Gi"

  hostname = "vm1"
  ssh_keys = [harvester_ssh_key.example.name]

  disks {
    name        = "rootdisk"
    image       = harvester_image.ubuntu.id
    size        = "20Gi"
    boot_order  = 1
  }

  networks {
    name = "nic-1"
    network_name = harvester_network.default.name
  }

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
