#!/bin/bash

DAML_MODEL_FILES=("daml-model/src/DA/Finance/Asset.daml"
                  "daml-model/src/DA/Finance/Types.daml"
                  "daml-model/src/DA/Finance/Asset/Lifecycle.daml"
                  "daml-model/src/DA/Finance/Asset/Settlement.daml"
                  "daml-model/src/DA/Finance/Base/HolidayCalendar.daml"
                  "daml-model/src/DA/Finance/Base/RollConvention.daml"
                  "daml-model/src/DA/Finance/Base/Schedule.daml"
                  "daml-model/src/DA/Finance/Instrument/Entitlement.daml"
                  "daml-model/src/DA/Finance/Instrument/Equity.daml"
                  "daml-model/src/DA/Finance/Trade/Dvp.daml"
                  "daml-model/src/DA/Finance/Trade/SettlementInstruction.daml"
                  "daml-model/src/DA/Finance/Trade/Dvp/Lifecycle.daml"
                  "daml-model/src/DA/Finance/Trade/Dvp/Settlement.daml"
                  )

DAML_TRIGGER_FILES=("daml-trigger/src/DA/Trigger/Finance/Asset/Lifecycle.daml"
                    "daml-trigger/src/DA/Trigger/Finance/Instrument/Entitlement.daml"
                    "daml-trigger/src/DA/Trigger/Finance/Instrument/Equity.daml"
                    "daml-trigger/src/DA/Trigger/Finance/Trade/SettlementInstruction.daml"
                    "daml-trigger/src/DA/Trigger/Finance/Trade/Dvp/Lifecycle.daml"
                    "daml-trigger/src/DA/Trigger/Finance/Trade/Dvp/Settlement.daml"
                    )

cd `dirname $0`
cd ..
daml damlc docs -o "docs/Reference_Model.md" -f "md" ${DAML_MODEL_FILES[@]} --combine --exclude-instances "HasField,Eq,Show,Ord,TemplateKey,HasExercise,HasFromAnyChoice,HasToAnyChoice,HasFetchByKey,HasLookupByKey,HasFromAnyContractKey,HasToAnyContractKey,HasKey,HasMaintainer" --exclude-modules "DA.**.Utils"
daml damlc docs -o "docs/Reference_Trigger.md" -f "md" ${DAML_TRIGGER_FILES[@]} --combine --exclude-instances "HasField,Eq,Show,Ord" --exclude-modules "DA.**.Utils" --package-db "daml-trigger/.daml/package-database"
