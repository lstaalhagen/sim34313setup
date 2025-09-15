#!/usr/bin/env bash

# Check for root, etc.
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 0
REALUSER=${SUDO_USER}
[ -z "${REALUSER}" ] && echo "Environment variable $SUDO_USER not set as expected" && exit

sudo -u ${REALUSER} install --mode=0777 start_omnetpp.sh /home/user/omnetpp-6.2.0

sudo -u ${REALUSER} rm /home/user/.local/share/applications/omnetpp*.desktop
sudo -u ${REALUSER} install --mode=0700 OMNeTpp.desktop /home/user/.local/applications

# Add user to vboxsf group
usermod -aG vboxsf user

# Handling models
sudo -u ${REALUSER} mkdir -p /home/user/Models
sudo -u ${REALUSER} install --mode=0755 getmodels.sh /home/user/Models
install --mode=0644 getmodels.service /etc/systemd/system/getmodels.service
systemctl daemon-reload
systemctl enable getmodels.service




