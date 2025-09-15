#!/usr/bin/env bash

cd /home/user/Models
/usr/bin/git clone http://github.com/lstaalhagen/sim34313models
if [ -d sim34313models ] ; then
  cp sim34313models/Models*.zip .
  rm -rf sim34313models
fi

