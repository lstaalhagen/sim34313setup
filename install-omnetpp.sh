#!/usr/bin/env bash

# Check for root, etc.
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 0
REALUSER=${SUDO_USER}
[ -z "${REALUSER}" ] && echo "Environment variable $SUDO_USER not set as expected" && exit

source ./env.sh

TGZFILE="omnetpp-${OMNETPPVERSION}-linux-x86_64.tgz"

sudo -u ${REALUSER} /bin/bash << EOF
cd ${HOMEDIR}
[ ! -f "${TGZFILE}" ] && wget -q https://github.com/omnetpp/omnetpp/releases/download/omnetpp-${OMNETPPVERSION}/${TGZFILE}
rm -rf ${OMNETPPDIR}
tar xzf $TGZFILE
cd ${OMNETPPDIR}
sed -i 's/WITH_OSG=.*/WITH_OSG=no/g' configure.user
source setenv
./configure
make
EOF

# install -o user -g user --mode=0755 start_omnetpp.sh ${HOMEDIR}/${OMNETPPDIR}/

# Fix desktop files
rm -f /home/user/.local/share/applications/omnetpp*.desktop /usr/share/applications/omnetpp*.desktop
install -o user -g user --mode=0700 OMNeTpp.desktop ${HOMEDIR}/.local/share/applications/

# Install start-script
install -o user -g user --mode=0755 start_omnetpp_skeleton.sh ${HOMEDIR}/${OMNETPPDIR}/start_omnetpp.sh
sed -i "s!TAG:CD_TO_OMNETPPDIR!cd ${HOMEDIR}/${OMNETPPDIR}!g" ${HOMEDIR}/${OMNETPPDIR}/start_omnetpp.sh
