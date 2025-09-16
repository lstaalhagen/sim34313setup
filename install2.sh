#!/usr/bin/env bash

# Check for root, etc.
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 0
REALUSER=${SUDO_USER}
[ -z "${REALUSER}" ] && echo "Environment variable $SUDO_USER not set as expected" && exit

cat << EOF > ./setup_omnetpp.sh
#!/usr/bin/env bash
cd /home/user
TGZFILE=omnetpp-6.2.0-linux-x86_64.tgz
[ ! -f "${TGZFILE}" ] && wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-6.2.0/${TGZFILE}
rm -rf omnetpp-6.2.0
tar xzf $TGZFILE
cd omnetpp-6.2.0
sed -i 's/WITH_OSG=.*/WITH_OSG=no/g' configure.user
source setenv
./configure
echo -n "Run 'make' command? (Will take a long time)"
read -r ANSWER
if [ "${ANSWER}" = "y" ] || [ "${ANSWER}" = "Y" ] ; then
  make
fi
EOF

sudo -u ${REALUSER} /bin/bash ./setup_omnetpp.sh
rm -f ./setup_omnetpp.sh
