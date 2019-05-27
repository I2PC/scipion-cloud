#!/usr/bin/env bash

# Install libraries
apt-get update
apt-get install -y libsm6 xterm lightdm xfce4 mesa-utils git python-pip openjdk-8-jdk libopenmpi-dev openmpi-bin gfortran cmake libxft-dev

# Create temporary dir for downloads
mkdir /tmp/scipion-deploy

# Add scipion user
#adduser --shell /bin/bash --disabled-password --gecos \"\" scipion