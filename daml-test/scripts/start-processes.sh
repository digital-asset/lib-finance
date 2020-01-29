#!/bin/bash
 
PARTIES=("Alice" "Charlie" "AcmeBank" "GencoBank")
PARTY_TRIGGER="Test.Trigger.Finance.Main:partyTrigger"
REUTERS_TRIGGER="Test.Trigger.Finance.Main:reutersTrigger"
TEST_SCRIPT="Test.Trigger.Finance.TestScript:test"

cd `dirname $0`
cd ..

for PARTY in ${PARTIES[@]}
do
  echo "Starting trigger for $PARTY"
  daml trigger --dar .daml/dist/finlib-test-1.0.0.dar -w --trigger-name $PARTY_TRIGGER --ledger-host "localhost" --ledger-port 6865 --ledger-party $PARTY &
done

echo "Starting trigger for Reuters"
daml trigger --dar .daml/dist/finlib-test-1.0.0.dar -w --trigger-name $REUTERS_TRIGGER --ledger-host "localhost" --ledger-port 6865 --ledger-party Reuters &

daml script --dar .daml/dist/finlib-test-1.0.0.dar -w --script-name $TEST_SCRIPT --input-file "scripts/config.json" --ledger-host "localhost" --ledger-port 6865
