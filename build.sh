#!/bin/sh
set -e
set -x
rm -rf output-debian12/
packer init -upgrade debian12.pkr.hcl
packer build debian12.pkr.hcl
guestfish << EOF
add output-debian12/packer-debian12
run
mount /dev/debian-vg/root /
mount /dev/sda2 /boot
mount /dev/sda1 /boot/efi
mkdir /boot/efi/EFI/BOOT
cp /boot/efi/EFI/debian/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.efi
EOF
