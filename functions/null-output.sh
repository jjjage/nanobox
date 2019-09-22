#!/bin/bash
# -o pipefail: do not ignore errors that occur in any command in a pipeline
# -u: do not ignore variable typos
# -e: do not ignore if any commands fail
set -euo pipefail

null_output() {
  #Usage: null_output commandhere
  #Description: Hides command output but if it failed, the output is shown

  #Sets TMPOUTPUT to a temporary file
  TMPOUTPUT=${tempfile}


  #Disables quit on error temporarily as we're handling it
  set +e
  #Redirects command STDOUT into the temporary file
  $@ &> $TMPOUTPUT
  #Get exit code of the command
  local EC=$?
  #Re-enables quit on error
  set -e

  #If command exited with non-zero code
  if [ $EC != 0 ]; then
    echo "Fatal error! Something went wrong:"
    #Outputs captured STDOUT
    echo $TMPOUTPUT
  fi

  #Removes temporary file
  rm -f $TMPOUTPUT
}
