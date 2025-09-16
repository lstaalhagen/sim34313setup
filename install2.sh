#!/usr/bin/env bash

# Check for root, etc.
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 0
REALUSER=${SUDO_USER}
[ -z "${REALUSER}" ] && echo "Environment variable $SUDO_USER not set as expected" && exit

# Install dependencies
apt -y install pkg-config bison flex python3-numpy python3-scipy python3-pandas \
               python3-matplotlib python3-ipython python3-dev qt6-base-dev qt6-base-dev-tools \
               qmake6 libqt6svg6 qt6-wayland libwebkit2gtk-4.1-0 ccache

# Install Wireshark silently
DEBIAN_FRONTEND=noninteractive apt-get -yq install wireshark

# Setup OMNeT++ as user
sudo -u ${REALUSER} /bin/bash ./setup_omnetpp.sh
