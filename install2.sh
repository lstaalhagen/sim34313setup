#!/usr/bin/env bash

# Check for root, etc.
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 0
REALUSER=${SUDO_USER}
[ -z "${REALUSER}" ] && echo "Environment variable $SUDO_USER not set as expected" && exit

# Install dependencies
apt -y install pkg-config bison flex python3-numpy python3-scipy python3-pandas \
               python3-matplotlib python3-ipython python3-dev qt6-base-dev qt6-base-dev-tools \
               qmake6 libqt6svg6 qt6-wayland libwebkit2gtk-4.1-0 ccache

# Change to home directory
cd /home/user
pwd

# Download OMNeT++ if tgz-file is not already present
TGZFILE=omnetpp-6.2.0-linux-x86_64.tgz
if [ ! -f "${TGZFILE}" ] ; then
  wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-6.2.0/${TGZFILE}
fi

# Delete old omnet directory and unpack tgz file
if [ -d omnetpp-6.2.0 ] ; then
  rm -rf omnetpp-6.2.0
fi
tar xzf $TGZFILE

cd omnetpp-6.2.0
sed -i 's/WITH_OSG=.*/WITH_OSG=no/g' configure.user
source setenv
./configure

echo "Run \'make\' command? (May take a long time)"
read -r ANSWER
if [ "${ANSWER}" = "y" ] || [ "${ANSWER}" = "Y" ] ; then
  make
fi
