#!/usr/bin/env bash

# Install TurboVNC

# Get debian package
wget -P  /tmp/scipion-deploy https://sourceforge.net/projects/turbovnc/files/2.1.1/turbovnc_2.1.1_amd64.deb

# Install package
dpkg -i /tmp/scipion-deploy/turbovnc_2.1.1_amd64.deb

# Configure tvncserver

sed -i -e 's+# VNCSERVERS="1:myusername"+VNCSERVERS="1:scipion"+g' /etc/sysconfig/tvncservers
sed -i -e 's+# VNCSERVERARGS\[1\]="-geometry 800x600 -nohttpd -localhost"+VNCSERVERARGS\[1\]="-geometry 800x600 -nohttpd"+g' /etc/sysconfig/tvncservers

update-rc.d tvncserver defaults

# Set vnc password (only temporary this should go on contextualization script)
mkdir /home/scipion/.vnc
chmod 0700 /home/scipion/.vnc
chown scipion.scipion /home/scipion/.vnc
mypasswd=$(tr -dc _A-H-J-N-P-Z-a-h-m-z-1-9 < /dev/urandom | head -c${1:-8})
echo $mypasswd | /opt/TurboVNC/bin/vncpasswd -f > /home/scipion/.vnc/passwd
chown -R scipion.scipion /home/scipion/.vnc
chmod 0600 /home/scipion/.vnc/passwd

# Create vnc startup file for user scipion
cat > /home/scipion/.vnc/xstartup.turbovnc << "EOF"
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
startxfce4 &
exit 0
EOF

chmod 0755 /home/scipion/.vnc/xstartup.turbovnc

# Disable remote-connections (only allow thorugh novnc)
sed -i -e 's+#no-remote-connections+no-remote-connections+g' /etc/turbovncserver-security.conf

# Install noVNC and websockify

git clone https://github.com/novnc/noVNC.git /opt/noVNC

#pip install websockify
git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify

# Add as a service to automatic start

cat > /etc/systemd/system/websockify.service << "EOF"
[Unit]
Description=websockify.service
#After=network.target

[Service]
#Type=forking
ExecStart= /opt/noVNC/utils/websockify/run 8000 localhost:5901 --web /opt/noVNC
Restart=on-failure

[Install]
WantedBy=default.target
EOF

systemctl enable websockify.service

# Remove debian packages
rm /tmp/scipion-deploy/turbovnc_2.1.1_amd64.deb














