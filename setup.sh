#!/bin/bash
# -o pipefail: do not ignore errors that occur in any command in a pipeline
# -u: do not ignore variable typos
# -e: do not ignore if any commands fail
set -euo pipefail

#Preflight checks before commencing install
############################################################################

#Check if script is being executed as root
echo "Checking if I am root..."
if [[ $EUID -ne 0 ]]; then
  echo "This script need to be run as root! Exiting!"
  exit
else
  echo "This script is running as root!"
fi

#Check system version
if [ "`lsb_release -d | sed 's/.*:\s*//' | sed 's/18\.04\.[0-9]/18.04/' `" == "Ubuntu 18.04 LTS" ]; then
  echo "This system is running Ubuntu 18.04!"
else
  echo "Either this system is not running Ubuntu 18.04 or lsb-release is not installed."
  exit
fi

echo "Nanobox Preflight Checks Complete!\n\n"

#Load core-setup.sh
source modules/core-setup.sh
