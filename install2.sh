#!/usr/bin/env bash

# Check for root, etc.
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 0
REALUSER=${SUDO_USER}
[ -z "${REALUSER}" ] && echo "Environment variable $SUDO_USER not set as expected" && exit

# cd
cd /home/user
pwd

# Download OMNeT++
TGZFILE=omnetpp-6.2.0-linux-x86_64.tgz
if [ ! -f "${TGZFILE}" ] ; then
  wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-6.2.0/${TGZFILE}
fi

# Expand
tar xzf $TGZFILE
