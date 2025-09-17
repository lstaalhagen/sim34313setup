#!/usr/bin/env bash

GITCMD="/usr/bin/git"
REPOSITORY="https://github.com/lstaalhagen/sim34313models"
DIRECTORY=$(basename ${REPOSITORY})

# Check for git command
[ ! -x ${GITCMD} ] && echo "Git not found. Exiting" && exit 1

cd /home/user/Models

# Check for repo existence
GIT_TERMINAL_PROMPT=no
${GITCMD} ls-remote ${REPOSITORY} HEAD &>/dev/null
if [ $? -ne 0 ] ; then
  echo "Error checking repository. Exiting"
  exit 1
fi

# Clone
rm -rf ${DIRECTORY}
${GITCMD} clone ${REPOSITORY}
if [ -d ${DIRECTORY} ] ; then
  cp ${DIRECTORY}/Models*.zip .
  rm -rf ${DIRECTORY}
fi
