#!/bin/bash

# This file is used by rpm and deb packages. FPM use.

if [ "$1" = "upgrade" ] || [ "$1" = "1" ] ; then
  exit 0
fi
