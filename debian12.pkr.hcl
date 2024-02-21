packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.9"
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
  efi_firmware_code = "/run/libvirt/nix-ovmf/OVMF_CODE.fd"
  efi_firmware_vars = "/run/libvirt/nix-ovmf/OVMF_VARS.fd"
  http_directory    = "preseed"
  iso_checksum      = "915bc47370ac7ecc35984c36be280c0b094bf79b0f1f9755142cc2f41384a0e4"
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
