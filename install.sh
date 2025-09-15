#!/usr/bin/env bash

# Check for root, etc.
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 0
REALUSER=${SUDO_USER}
[ -z "${REALUSER}" ] && echo "Environment variable $SUDO_USER not set as expected" && exit

# Update packages
apt update && apt -y upgrade
apt update && apt -y autoremove

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
