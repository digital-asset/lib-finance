# <a name="module-da-trigger-finance-asset-lifecycle-46311"></a>Module DA.Trigger.Finance.Asset.Lifecycle

## Functions

<a name="function-da-trigger-finance-asset-lifecycle-trigger-20052"></a>[trigger](#function-da-trigger-finance-asset-lifecycle-trigger-20052)

> : (LifecycleEffects -\> [Bool](https://docs.daml.com/daml/reference/base.html#type-ghc-types-bool-8654)) -\> Trigger ()
> 
> A trigger to lifecycle `AssetDeposit` contracts. It listens to
> `LifecycleEffects` contracts and eagerly applies them. The asset
> effects end up in the different account, e.g. cash dividends.
> 
> Inputs:
> 
> `pred` (LifecycleEffects -> Bool): A predicate to filter `LifecycleEffects`
> contracts that are processed. The trigger cannot handle cases where
> the asset effects end up in different accounts.

# <a name="module-da-trigger-finance-instrument-entitlement-63728"></a>Module DA.Trigger.Finance.Instrument.Entitlement

## Functions

<a name="function-da-trigger-finance-instrument-entitlement-trigger-17001"></a>[trigger](#function-da-trigger-finance-instrument-entitlement-trigger-17001)

> : RelTime -\> RelTime -\> Trigger ()
> 
> A trigger that eagerly processes `Entitlement` contracts once they settle.
> 
> Inputs:
> 
> `settlementOffset` (RelTime): Offset to the settlement date when the settlement
> happens.
> 
> `heartbeat` (RelTime): The heartbeat of the trigger.

# <a name="module-da-trigger-finance-instrument-equity-59909"></a>Module DA.Trigger.Finance.Instrument.Equity

## Functions

<a name="function-da-trigger-finance-instrument-equity-trigger-37722"></a>[trigger](#function-da-trigger-finance-instrument-equity-trigger-37722)

> : RelTime -\> RelTime -\> (Id -\> [Text](https://docs.daml.com/daml/reference/base.html#type-ghc-types-text-57703)) -\> Trigger ()
> 
> A trigger that eagerly processes equity lifecycle event contracts
> (`EquityCashDividend`, `EquityStockSplit`) once they are due.
> 
> Inputs:
> 
> `settlementOffset` (RelTime): Offset to the ex date when the lifecycle event
> is processed.
> 
> `heartbeat` (RelTime): The heartbeat of the trigger.
> 
> `toEntitlementIdLabel` (Id -> Text): A function to derive the entitlement label
> from the id of the lifecycle event (e.g. for `EquityCashDividend`).

# <a name="module-da-trigger-finance-trade-dvp-lifecycle-37665"></a>Module DA.Trigger.Finance.Trade.Dvp.Lifecycle

## Functions

<a name="function-da-trigger-finance-trade-dvp-lifecycle-trigger-83110"></a>[trigger](#function-da-trigger-finance-trade-dvp-lifecycle-trigger-83110)

> : Trigger ()
> 
> A trigger to lifecycle `Dvp` contracts. It listens to `LifecycleEffects`
> contracts and eagerly applies them. If multiple LifecycleEffects contracts
> are affecting a single dvp, they are  applied sequentially.

# <a name="module-da-trigger-finance-trade-dvp-settlement-58597"></a>Module DA.Trigger.Finance.Trade.Dvp.Settlement

## Functions

<a name="function-da-trigger-finance-trade-dvp-settlement-trigger-99466"></a>[trigger](#function-da-trigger-finance-trade-dvp-settlement-trigger-99466)

> : RelTime -\> RelTime -\> Trigger ()
> 
> A trigger to settle `Dvp` contracts once all allocated `SettlementInstruction`
> contracts are available and the current time is after the settlement date.
> 
> Inputs:
> 
> `settlementOffset` (RelTime): Offset to the settlement date when the settlement happens.
> 
> `heartbeat` (RelTime): The heartbeat of the trigger.

# <a name="module-da-trigger-finance-trade-settlementinstruction-82076"></a>Module DA.Trigger.Finance.Trade.SettlementInstruction

## Templates

<a name="type-da-trigger-finance-trade-settlementinstruction-allocationrule-40354"></a>**template** [AllocationRule](#type-da-trigger-finance-trade-settlementinstruction-allocationrule-40354)

> Rule that helps to allocate `AssetDeposit` to `SettlementInstruction`
> contracts by atomically merging and splitting the deposits.
> 
> | Field | Type  | Description |
> | :---- | :---- | :---------- |
> | sig   | Party | The signatory. |
> 
> * **Choice Allocate**
>   
>   Allows the `sig` to allocate deposits to settlement
>   instructions. Expects deposits of the same asset in the
>   same account.
>   
>   | Field                                | Type                                 | Description |
>   | :----------------------------------- | :----------------------------------- | :---------- |
>   | instructionCids                      | \[ContractId SettlementInstruction\] | The settlement instructions that are allocated. |
>   | depositCids                          | \[ContractId AssetDeposit\]          | The deposits that are used for allocation. Need to be mergeable. |
> 
> * **Choice Archive**
>   
>   (no fields)

## Functions

<a name="function-da-trigger-finance-trade-settlementinstruction-trigger-11941"></a>[trigger](#function-da-trigger-finance-trade-settlementinstruction-trigger-11941)

> : Trigger ()
> 
> A trigger that eagerly allocates `AssetDeposit` contracts
> to `SettlementInstruction` contracts.
