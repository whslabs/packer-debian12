packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.9"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "debian12" {
  accelerator    = "kvm"
  boot_wait      = "5s"
  disk_size      = "100G"
  efi_boot       = true
  http_directory = "preseed"
  iso_checksum   = "61bd4ac9215a418924b48442ff84870082602b390b98037e5699e1fb0c6cb700"
  iso_url        = "https://deb.debian.org/debian/dists/bookworm/main/installer-amd64/current/images/netboot/mini.iso"
  memory         = 4096
  cpus           = 4
  ssh_password   = "packer"
  ssh_username   = "packer"
  ssh_timeout    = "1h"
  boot_command = [
    "e<down><down><down><end> ",
    "auto=true priority=critical url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<f10>"
  ]
}

build {
  sources = ["source.qemu.debian12"]
}
