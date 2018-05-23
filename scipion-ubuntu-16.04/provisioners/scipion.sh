#!/usr/bin/env bash

# Get scipion binaries
wget -P /tmp/scipion-deploy http://scipion.cnb.csic.es/downloads/scipion/software/binary/scipion_v1.2_2018-04-02_linux64.tgz

tar xfz /tmp/scipion-deploy/scipion_v1.2_2018-04-02_linux64.tgz -C /opt/

# Config scipion
/opt/scipion/scipion config --notify

# Modify cuda var on scipion config
sed -i -e "s+/usr/local/cuda-7.5+/usr/local/cuda+g" /opt/scipion/config/scipion.conf

# Install chimera 1.10.1
/opt/scipion/scipion install --no-xmipp chimera

# Install relion 2.1
/opt/scipion/scipion install --no-xmipp relion

# Install ctffind4 4.1.10
/opt/scipion/scipion install --no-xmipp ctffind4

# Install motioncor2 1.0.5
/opt/scipion/scipion install --no-xmipp motioncor2

# Install Gctf 1.06
/opt/scipion/scipion install --no-xmipp Gctf

# Install Gautomatch 0.53
/opt/scipion/scipion install --no-xmipp Gautomatch

# Install eman 2.12
/opt/scipion/scipion install --no-xmipp eman

# Install spider 21.13
/opt/scipion/scipion install --no-xmipp spider

# Install frealing 9.07
/opt/scipion/scipion install --no-xmipp frealign

# Install resmap 1.1.5s2
/opt/scipion/scipion install --no-xmipp resmap

# Delete scipion binary file
rm /tmp/scipion-deploy/scipion_v1.2_2018-04-02_linux64.tgz

# Delete em packages tar files
rm /opt/scipion/software/em/*.tgz

# Change ownership of scipion folder
chown -R scipion.scipion /opt/scipion

# Config scipion for scipion user
su - scipion -c "/opt/scipion/scipion config --notify"

# Modify Gctf and Gautomatch cuda versions
sed -i -e "s+Gctf-v1.06_sm_20_cu7.5+Gctf-v1.06_sm_20_cu8.0+g" /home/scipion/.config/scipion/scipion.conf
sed -i -e "s+Gautomatch-v0.53_sm_20_cu7.5+Gautomatch-v0.53_sm_20_cu8.0+g" /home/scipion/.config/scipion/scipion.conf







