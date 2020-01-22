#!/bin/bash

DIR=$(dirname $0)
daml start --start-navigator "no" --on-start "$DIR/start-trigger.sh"
