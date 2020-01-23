#!/bin/bash

DIR=$(dirname $0)
daml start --start-navigator "no" --sandbox-option "-w" &

sleep 5
echo "Timed out"
exit -1
