#!/usr/bin/env bash

# Install libraries
apt-get update
apt-get install -y libsm6 xterm lightdm xfce4 mesa-utils git curl python-pip openjdk-8-jdk libopenmpi-dev openmpi-bin gfortran cmake libxft-dev libssl-dev libxext-dev libxml2-dev libreadline6 libquadmath0 libxslt1-dev libxss-dev libgsl0-dev libx11-dev libfreetype6-dev scons libfftw3-dev

# Create temporary dir for downloads
mkdir /tmp/scipion-deploy