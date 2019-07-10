#!/usr/bin/env bash

# Get scipion binaries
wget -P /tmp/scipion-deploy http://scipion.i2pc.es/startdownload/?bundleId=4

tar xfz /tmp/scipion-deploy/index.html?bundleId=4 -C /opt/

# Delete scipion binary file
rm /tmp/scipion-deploy/index.html?bundleId=4

# Config scipion
/opt/scipion/scipion config --notify

# Modify cuda var on scipion config
#sed -i -e "s+/usr/local/cuda-7.5+/usr/local/cuda+g" /opt/scipion/config/scipion.conf

# Install xmipp plugin
/opt/scipion/scipion installp -p scipion-em-xmipp

# Install xmipp and compile sources
/opt/scipion/scipion installb xmippBin_Debian

# Delete em packages tar files (to free some space)
rm /opt/scipion/software/em/*.tgz

# Install chimera plugin
/opt/scipion/scipion installp -p scipion-em-chimera

# Install relion plugin (and compile relion sources)
/opt/scipion/scipion installp -p scipion-em-relion

# Install grigoriefflab plugin
/opt/scipion/scipion installp -p scipion-em-grigoriefflab

# Install eman2 plugin
/opt/scipion/scipion installp -p scipion-em-eman2

# Install spider plugin
/opt/scipion/scipion installp -p scipion-em-spider

# Install resmap plugin
/opt/scipion/scipion installp -p scipion-em-resmap

# Install EM packages GPU dependent (only for GPU image)

# Install Gctf plugin
#/opt/scipion/scipion installp -p scipion-em-gctf

# Install Gautomatch plugin
#/opt/scipion/scipion installp -p scipion-em-gautomatch

# Install motioncor2 plugin
#/opt/scipion/scipion installp -p scipion-em-motioncorr

# Delete em packages tar files
rm /opt/scipion/software/em/*.tgz

# Change ownership of scipion folder
chown -R scipion.scipion /opt/scipion

# Config scipion for scipion user
su - scipion -c "/opt/scipion/scipion config --notify"

# Modify Gctf and Gautomatch cuda versions
#sed -i -e "s+Gctf-v1.06_sm_20_cu7.5+Gctf-v1.06_sm_20_cu8.0+g" /home/scipion/.config/scipion/scipion.conf
#sed -i -e "s+Gautomatch-v0.53_sm_20_cu7.5+Gautomatch-v0.53_sm_20_cu8.0+g" /home/scipion/.config/scipion/scipion.conf







