#!/usr/bin/env bash

# Get mesa software
wget -P /tmp/scipion-deploy http://scipion.cnb.csic.es/downloads/scipion/software/em/mesa-11.0.7-compiled.tgz
tar xfz /tmp/scipion-deploy/mesa-11.0.7-compiled.tgz -C /opt/scipion/software/em/

# Modify REMOTE_MESA_LIB variables to point to the right location
sed -i -e "s+/services/guacamole/usr/mesa/lib/+/opt/scipion/software/em/mesa-11.0.7/lib/+g" /opt/scipion/config/scipion.conf

# Create scipion desktop shortcut
mkdir /home/scipion/Desktop

cat > /home/scipion/Desktop/scipion.desktop << "EOF"
[Desktop Entry]
Version=1.0
Type=Application
Name=Scipion
Comment=Scipion run
Exec=/opt/scipion/scipion
Icon=/opt/scipion/pyworkflow/resources/scipion_logo.png
Terminal=true
StartupNotify=false
EOF

# Change ownership of shortcut
chown -R scipion.scipion /home/scipion/Desktop