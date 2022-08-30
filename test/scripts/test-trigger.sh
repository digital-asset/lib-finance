#!/bin/bash

USERS=("alice" "charlie" "acmebank" "gencobank")
PARTY_TRIGGER="Test.Trigger.Finance.Main:partyTrigger"
REUTERS_TRIGGER="Test.Trigger.Finance.Main:reutersTrigger"
SETUP_SCRIPT="Test.SetupScript:setup"
TEST_SCRIPT="Test.Trigger.Finance.TestScript:test"

function waitForPortfile {
  until [ -f .daml/portfile.txt ]
  do
      sleep 5
  done
  echo "Sandbox started"
}

DIR=$(dirname $0)

# Start and wait for sandbox
rm -f .daml/portfile.txt
daml sandbox --dar .daml/dist/finlib-test-2.0.1.dar --port-file .daml/portfile.txt --wall-clock-time &
SANDBOX_PID=$!
waitForPortfile

# Run setup script to allocate users and parties
export _JAVA_OPTIONS="-Xms256m -Xmx1g"
daml script --dar .daml/dist/finlib-test-2.0.1.dar -w --script-name $SETUP_SCRIPT --ledger-host "localhost" --ledger-port 6865
STATUS=$?

#Start triggers
export _JAVA_OPTIONS="-Xms64m -Xmx256m"

TRIGGER_PARTY_PIDS=()
for USER in ${USERS[@]}
do
  echo "Starting trigger for $USER"
  daml trigger --dar .daml/dist/finlib-test-2.0.1.dar -w --trigger-name $PARTY_TRIGGER --ledger-host "localhost" --ledger-port 6865 --ledger-user $USER &
  TRIGGER_PARTY_PIDS+=($!)
done

echo "Starting trigger for Reuters"
daml trigger --dar .daml/dist/finlib-test-2.0.1.dar -w --trigger-name $REUTERS_TRIGGER --ledger-host "localhost" --ledger-port 6865 --ledger-user reuters &
TRIGGER_REUTERS_PID=$!

#Start script
export _JAVA_OPTIONS="-Xms256m -Xmx1g"
daml script --dar .daml/dist/finlib-test-2.0.1.dar -w --script-name $TEST_SCRIPT --ledger-host "localhost" --ledger-port 6865 --input-file "scripts/config.json"
STATUS=$?

#kill all processes
echo "Shutting processes down"
kill $TRIGGER_REUTERS_PID
for PID in ${TRIGGER_PARTY_PIDS[@]}
do kill $PID
done
kill $SANDBOX_PID

exit $STATUS
