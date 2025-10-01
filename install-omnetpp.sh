#!/usr/bin/env bash

# Check for root, etc.
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 0
REALUSER=${SUDO_USER}
[ -z "${REALUSER}" ] && echo "Environment variable $SUDO_USER not set as expected" && exit

source ./env.sh

TGZFILE="omnetpp-${OMNETPPVERSION}-linux-x86_64.tgz"

sudo -u ${REALUSER} /bin/bash << EOF
cd ${HOMEDIR}
echo "# Downloading OMNeT++"
[ ! -f "${TGZFILE}" ] && wget -q https://github.com/omnetpp/omnetpp/releases/download/omnetpp-${OMNETPPVERSION}/${TGZFILE}
rm -rf ${OMNETPPDIR}
echo "# Expanding tgz file"
tar xzf $TGZFILE
cd ${OMNETPPDIR}
sed -i 's/WITH_OSG=.*/WITH_OSG=no/g' configure.user
source setenv
./configure
echo "# Making OMNeT++"
make -j4
EOF

# Fix desktop files
rm -f ${HOMEDIR}/.local/share/applications/omnetpp*.desktop /usr/share/applications/omnetpp*.desktop
install -o user -g user --mode=0700 OMNeTpp_skeleton.desktop ${HOMEDIR}/.local/share/applications/OMNeTpp.desktop
sed -i "s!TAG:OMNETPPDIR!${HOMEDIR}/${OMNETPPDIR}!g" ${HOMEDIR}/.local/share/applications/OMNeTpp.desktop
sed -i "s!TAG:OMNETPPVERSION!${OMNETPPVERSION}!g" ${HOMEDIR}/.local/share/applications/OMNeTpp.desktop

# Install start-script
install -o user -g user --mode=0755 start_omnetpp_skeleton.sh ${HOMEDIR}/${OMNETPPDIR}/start_omnetpp.sh
sed -i "s!TAG:OMNETPPDIR!${HOMEDIR}/${OMNETPPDIR}!g" ${HOMEDIR}/${OMNETPPDIR}/start_omnetpp.sh
