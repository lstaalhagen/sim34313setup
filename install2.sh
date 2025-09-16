#!/usr/bin/env bash

# Check for root, etc.
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 0
REALUSER=${SUDO_USER}
[ -z "${REALUSER}" ] && echo "Environment variable $SUDO_USER not set as expected" && exit

OMNETPPVER="6.2.0"
TGZFILE="omnetpp-${OMNETPPVER}-linux-x86_64.tgz"

sudo -u ${REALUSER} /bin/bash << EOF
cd /home/user
[ ! -f "${TGZFILE}" ] && wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-${OMNETPPVER}/${TGZFILE}
rm -rf omnetpp-${OMNETPPVER}
tar xzf $TGZFILE
cd omnetpp-${OMNETPPVER}
sed -i 's/WITH_OSG=.*/WITH_OSG=no/g' configure.user
source setenv
./configure
make
EOF
