#!/usr/bin/env bash

GITCMD="/usr/bin/git"
REPOSITORY="https://github.com/lstaalhagen/sim34313models"
DIRECTORY=$(basename ${REPOSITORY})
SIMDIR=/home/user/Simulations

# Check for git command
[ ! -x ${GITCMD} ] && echo "Git not found. Exiting" && exit 1

# Switch to main Models directory
cd /home/user/Models

# Check for repo availability
GIT_TERMINAL_PROMPT=no
${GITCMD} ls-remote ${REPOSITORY} HEAD &>/dev/null
if [ $? -ne 0 ] ; then
  echo "Error checking repository. Exiting"
  exit 1
fi

# Clone repo and copy zip-files to main Models directory
rm -rf ${DIRECTORY}
${GITCMD} clone ${REPOSITORY}
if [ -d ${DIRECTORY} ] ; then
  cp ${DIRECTORY}/*.zip .
  rm -rf ${DIRECTORY}
fi

# Unzip missing project zip-files to Simulation directory
for ZIPFILE in $(ls *.zip) ; do
  PROJNAME=$(basename ${ZIPFILE} .zip)
  if [ ! -d ${SIMDIR}/${PROJNAME} ] ; then
    unzip -qq -d ${SIMDIR} ${ZIPFILE}
  fi
done
