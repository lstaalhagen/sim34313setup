#!/usr/bin/env bash

# Check for root, etc.
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 0
REALUSER=${SUDO_USER}
[ -z "${REALUSER}" ] && echo "Environment variable $SUDO_USER not set as expected" && exit

source ./env.sh

# Update packages
apt update && apt -y upgrade
apt update && apt -y autoremove

# Install dependencies
apt -y install pkg-config bison flex python3-numpy python3-scipy python3-pandas \
               python3-matplotlib python3-ipython python3-dev qt6-base-dev qt6-base-dev-tools \
               qmake6 libqt6svg6 qt6-wayland libwebkit2gtk-4.1-0 ccache htop

# Install Wireshark silently
DEBIAN_FRONTEND=noninteractive apt-get -yq install wireshark

# Clean up apt cache to save space
apt clean

# Fix Grub to have a visible menu shortly
sed -i 's/GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=menu/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=2/g' /etc/default/grub
update-grub

# Stop/remove misc irrelevant services listed in file 'disablelist'
if [ -s disablelist ] ; then
  for p in $(cat disablelist) ; do
    systemctl stop ${p}
    systemctl mask ${p}
  done
fi

# Setup automatic download of model files from GitHub at boot
sudo -u ${REALUSER} mkdir -p ${HOMEDIR}/Models
install -o user -g user --mode=0755 getmodels.sh ${HOMEDIR}/Models/
install --mode=0644 getmodels_skeleton.service /etc/systemd/system/getmodels.service
sed -i "s!TAG:MODELSDIR!${MODELSDIR}!g" /etc/systemd/system/getmodels.service
systemctl daemon-reload
systemctl enable getmodels.service

# Create directory for simulations
sudo -u ${REALUSER} mkdir -p ${SIMULATIONDIR}
