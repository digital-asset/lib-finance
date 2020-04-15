#!/bin/bash

DAML_MODEL_FILES=("model/src/DA/Finance/Asset.daml"
                  "model/src/DA/Finance/Types.daml"
                  "model/src/DA/Finance/Asset/Lifecycle.daml"
                  "model/src/DA/Finance/Asset/Settlement.daml"
                  "model/src/DA/Finance/Base/HolidayCalendar.daml"
                  "model/src/DA/Finance/Base/RollConvention.daml"
                  "model/src/DA/Finance/Base/Schedule.daml"
                  "model/src/DA/Finance/Instrument/Equity/ACBRC/Lifecycle.daml"
                  "model/src/DA/Finance/Instrument/Equity/Option/Lifecycle.daml"
                  "model/src/DA/Finance/Instrument/Equity/Stock/Lifecycle.daml"
                  "model/src/DA/Finance/Instrument/Equity/ACBRC.daml"
                  "model/src/DA/Finance/Instrument/Equity/CashDividend.daml"
                  "model/src/DA/Finance/Instrument/Equity/Option.daml"
                  "model/src/DA/Finance/Instrument/Equity/Stock.daml"
                  "model/src/DA/Finance/Instrument/Equity/StockSplit.daml"
                  "model/src/DA/Finance/Instrument/FixedIncome/FixedRateBond/Lifecycle.daml"
                  "model/src/DA/Finance/Instrument/FixedIncome/FixedRateBond.daml"
                  "model/src/DA/Finance/Instrument/FX/Currency.daml"
                  "model/src/DA/Finance/Instrument/Entitlement.daml"
                  "model/src/DA/Finance/RefData/Fixing.daml"
                  "model/src/DA/Finance/Trade/Dvp/Lifecycle.daml"
                  "model/src/DA/Finance/Trade/Dvp/Settlement.daml"
                  "model/src/DA/Finance/Trade/Dvp.daml"
                  "model/src/DA/Finance/Trade/SettlementInstruction.daml"
                  )

DAML_TRIGGER_FILES=("trigger/src/DA/Trigger/Finance/Asset/Lifecycle.daml"
                    "trigger/src/DA/Trigger/Finance/Instrument/Entitlement.daml"
                    "trigger/src/DA/Trigger/Finance/Instrument/Equity/Stock.daml"
                    "trigger/src/DA/Trigger/Finance/Instrument/Equity/Option.daml"
                    "trigger/src/DA/Trigger/Finance/Trade/SettlementInstruction.daml"
                    "trigger/src/DA/Trigger/Finance/Trade/Dvp/Lifecycle.daml"
                    "trigger/src/DA/Trigger/Finance/Trade/Dvp/Settlement.daml"
                    )

cd `dirname $0`
cd ..
daml damlc docs -o "docs/Reference_Model.md" -f "md" ${DAML_MODEL_FILES[@]} --combine --exclude-instances "HasField,Eq,Show,Ord,TemplateKey,HasExercise,HasFromAnyChoice,HasToAnyChoice,HasFetchByKey,HasLookupByKey,HasFromAnyContractKey,HasToAnyContractKey,HasKey,HasMaintainer" --exclude-modules "DA.**.Utils"
daml damlc docs -o "docs/Reference_Trigger.md" -f "md" ${DAML_TRIGGER_FILES[@]} --combine --exclude-instances "HasField,Eq,Show,Ord" --exclude-modules "DA.**.Utils" --package-db "daml-trigger/.daml/package-database"
