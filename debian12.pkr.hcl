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
  iso_checksum      = "1c8f5ee61b0bc1da1ee2e32cf9c60f4c381523a468b0ae82170a17592979a783"
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
