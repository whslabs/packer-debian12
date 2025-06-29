```sh
./build.sh
(
name=debian12
cp output-debian12/packer-debian12 ~/$name.qcow2
virt-install \
  --boot loader=/usr/share/edk2/ovmf/OVMF_CODE.fd \
  --connect qemu:///system \
  --disk ~/$name.qcow2 \
  --import \
  --memory 2048 \
  --name $name \
  --network bridge:virbr0 \
  --os-variant debian12 \
  --vcpus 2 \
  ;
)
```
# Mozc
```sh
sudo apt-get install -y ibus-mozc
```
