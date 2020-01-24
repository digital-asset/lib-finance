#!/bin/bash
 
PARTY_TRIGGERS=("Test.Trigger.Finance.Main:assetLifecycleTrigger"
                "Test.Trigger.Finance.Main:instructionTrigger"
                "Test.Trigger.Finance.Main:dvpLifecycleTrigger"
                "Test.Trigger.Finance.Main:dvpSettlementTrigger"
                )
PARTIES=("Alice" "Charlie" "AcmeBank" "GencoBank")
REUTERS_TRIGGERS=("Test.Trigger.Finance.Main:entitlementTrigger"
                  "Test.Trigger.Finance.Main:equityTrigger"
                 )
TEST_SCRIPT="Test.Trigger.Finance.TestScript:test"

cd `dirname $0`
cd ..

for TRIGGER in ${PARTY_TRIGGERS[@]}
do
  for PARTY in ${PARTIES[@]}
  do
    echo "Starting $TRIGGER for $PARTY"
    daml trigger --dar .daml/dist/finlib-test-1.0.0.dar -w --trigger-name $TRIGGER --ledger-host "localhost" --ledger-port 6865 --ledger-party $PARTY &
  done
done

for TRIGGER in ${REUTERS_TRIGGERS[@]}
do
  echo "Starting $TRIGGER for Reuters"
  daml trigger --dar .daml/dist/finlib-test-1.0.0.dar -w --trigger-name $TRIGGER --ledger-host "localhost" --ledger-port 6865 --ledger-party Reuters &
done

daml script --dar .daml/dist/finlib-test-1.0.0.dar -w --script-name $TEST_SCRIPT --input-file "scripts/config.json" --ledger-host "localhost" --ledger-port 6865
