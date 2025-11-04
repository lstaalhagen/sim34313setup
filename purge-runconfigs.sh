#!/usr/bin/env bash

if [ ! -d .metadata ] ; then
  echo "Doesn't look like the current directory is a workspace. Bailing out ..."
  exit 1
fi

rm -f .metadata/.plugins/org.eclipse.debug.core/.launches/*.launch
