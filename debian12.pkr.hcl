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
  iso_checksum      = "1fe0e4bbee530a541ea1e3eb7e720cda89c0ef6d9f18da1c2469392cfeff9b48"
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
