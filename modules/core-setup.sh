#!/bin/bash
# -o pipefail: do not ignore errors that occur in any command in a pipeline
# -u: do not ignore variable typos
# -e: do not ignore if any commands fail
set -euo pipefail

#Load functions needed
source functions/null-output.sh

echo "Starting core system configuration..."

#Change timezone to UTC to prevent strange software issues
echo "Configuring timezone to UTC..."
echo "Etc/UTC" > /etc/timezone
restart_service rsyslog
echo "Timezone changed to UTC!"

echo "Updating APT cache..."
null_output apt update
echo "APT cache updated!"
