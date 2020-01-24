#!/bin/bash

DIR=$(dirname $0)

function local {
  daml start --start-navigator "no" --sandbox-option "-w" --on-start "$DIR/start-processes.sh"
}

function circleci {
  rm -f test.log
  daml start --start-navigator "no" --sandbox-option "-w" --on-start "$DIR/start-processes.sh" 2>&1 | tee test.log &

  # Run until 'Test finished' is found in logs
  while [ true ]; do
    echo "Running.."
    result=$(grep -F 'TestScript Finished' test.log)
    if [ "$result" ] ; then
      echo "Test finished"
      break
    fi

    sleep 10
  done
  exit 0
}

case $1 in

  local)
    local
    ;;
  circleci)
    circleci
    ;;
  *)
    echo "argument 'local' or 'cirecleci' rqeuired"
    ;;
esac


