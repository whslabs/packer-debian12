packer {
  required_plugins {
    qemu = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "debian12" {
  accelerator       = "kvm"
  boot_wait         = "5s"
  cpus              = 4
  disk_size         = "100G"
  efi_boot          = true
  http_directory    = "preseed"
  iso_checksum      = "402c0b876c7da0f5682a68a6705636592aa217fe934a64ee36f731e9afc6b99f"
  iso_url           = "https://deb.debian.org/debian/dists/bookworm/main/installer-amd64/current/images/netboot/mini.iso"
  memory            = 4096
  ssh_password      = "packer"
  ssh_timeout       = "1h"
  ssh_username      = "packer"
  boot_command = [
    "e<down><down><down><end> ",
    "auto=true priority=critical url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<f10>"
  ]
}

build {
  sources = ["source.qemu.debian12"]
}
