#!/usr/bin/env bash

# Check for root, etc.
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 0
REALUSER=${SUDO_USER}
[ -z "${REALUSER}" ] && echo "Environment variable $SUDO_USER not set as expected" && exit

# install -o user -g user --mode=0755 start_omnetpp.sh /home/user/omnetpp-6.2.0/

# Remove old desktop files
# rm -f /home/user/.local/share/applications/omnetpp*.desktop
# rm -f /usr/share/applications/omnetpp*.desktop

# Install our desktop
# install -o user -g user --mode=0700 OMNeTpp.desktop /home/user/.local/share/applications/

# Add user to vboxsf group
# usermod -aG vboxsf user

# Handling models
# sudo -u ${REALUSER} mkdir -p /home/user/Models
# install -o user -g user --mode=0755 getmodels.sh /home/user/Models/
# install --mode=0644 getmodels.service /etc/systemd/system/
# systemctl daemon-reload
# systemctl enable getmodels.service

# Create directory for simulations
# sudo -u ${REALUSER} mkdir -p /home/user/Simulations
