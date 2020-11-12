#!/bin/bash

PARTIES=("Alice" "Charlie" "AcmeBank" "GencoBank")
PARTY_TRIGGER="Test.Trigger.Finance.Main:partyTrigger"
REUTERS_TRIGGER="Test.Trigger.Finance.Main:reutersTrigger"
TEST_SCRIPT="Test.Trigger.Finance.TestScript:test"

function waitForPortfile {
  until [ -f .daml/portfile.txt ]
  do
      sleep 5
  done
  echo "Sandbox started"
}

DIR=$(dirname $0)

# Start and wati for sandbox
rm -f .daml/portfile.txt
daml sandbox -w .daml/dist/finlib-test-2.0.0.dar --port-file .daml/portfile.txt &
SANDBOX_PID=$!
waitForPortfile

#Start triggers
export _JAVA_OPTIONS="-Xms64m -Xmx256m"

TRIGGER_PARTY_PIDS=()
for PARTY in ${PARTIES[@]}
do
  echo "Starting trigger for $PARTY"
  daml trigger --dar .daml/dist/finlib-test-2.0.0.dar -w --trigger-name $PARTY_TRIGGER --ledger-host "localhost" --ledger-port 6865 --ledger-party $PARTY &
  TRIGGER_PARTY_PIDS+=($!)
done

echo "Starting trigger for Reuters"
daml trigger --dar .daml/dist/finlib-test-2.0.0.dar -w --trigger-name $REUTERS_TRIGGER --ledger-host "localhost" --ledger-port 6865 --ledger-party Reuters &
TRIGGER_REUTERS_PID=$!

#Start script
export _JAVA_OPTIONS="-Xms256m -Xmx1g"
daml script --dar .daml/dist/finlib-test-2.0.0.dar -w --script-name $TEST_SCRIPT --input-file "scripts/config.json" --ledger-host "localhost" --ledger-port 6865
STATUS=$?

#kill all processes
kill $TRIGGER_REUTERS_PID
for PID in ${TRIGGER_PARTY_PIDS[@]}
do kill $PID
done
kill $SANDBOX_PID

exit $STATUS
