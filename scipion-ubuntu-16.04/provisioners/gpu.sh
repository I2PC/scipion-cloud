#!/usr/bin/env bash

# Install cuda toolkit

wget -P /tmp/scipion-deploy https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
dpkg -i /tmp/scipion-deploy/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
apt-get update
apt-get install -y cuda-8-0

# Install VirtualGL

wget -P /tmp/scipion-deploy https://sourceforge.net/projects/virtualgl/files/2.5.2/virtualgl_2.5.2_amd64.deb

dpkg -i /tmp/scipion-deploy/virtualgl_2.5.2_amd64.deb

# Configure VirtualGL

service lightdm stop
/opt/VirtualGL/bin/vglserver_config -config
usermod -a -G vglusers scipion
service lightdm start

# Blackist nouveau driver

echo "blacklist nouveau" > /etc/modprobe.d/nouveau.conf

# Configure nvidia (this gives an error when no GPU is present but it works, this should go on a contextualization script instead)

nvidia-xconfig -a --use-display-device=None --virtual=1920x1200 --preserve-busid

# Remove debian package
rm /tmp/scipion-deploy/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
rm /tmp/scipion-deploy/virtualgl_2.5.2_amd64.deb

# Create scipion desktop shortcut
mkdir /home/scipion/Desktop

cat > /home/scipion/Desktop/scipion.desktop << "EOF"
[Desktop Entry]
Version=1.0
Type=Application
Name=Scipion
Comment=Scipion run with vglrun
Exec=/opt/VirtualGL/bin/vglrun /opt/scipion/scipion
Icon=/opt/scipion/pyworkflow/resources/scipion_logo.png
Terminal=true
StartupNotify=false
EOF

# Change ownership of shortcut
chown -R scipion.scipion /home/scipion/Desktop








