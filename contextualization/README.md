# How to inject contextualization data to virtualbox appliance
Generate ISO:

`genisoimage -output vbox-config.iso -volid cidata -joliet -r meta-data user-data`

On VirtualBox:
- import ova
- Configure on Storage: Add Optical disk and select vbox-config.iso
- Configure on Network/Advanced/Port forwarding 8000 and 22
