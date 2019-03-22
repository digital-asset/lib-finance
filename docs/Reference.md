# Module DA.Finance.Fact.Asset

    Copyright (c) 2019, Digital Asset (Switzerland) GmbH and/or its affiliates. All rights reserved.
    SPDX-License-Identifier: Apache-2.0

## Templates

### Template `AssetDecomposition`

Describes a decomposition of one asset into n other assets and the corresponding
scaling factors. Can be used to process corporate actions such as an equity cash
dividend that increases the asset's version number and creates a separate entitlement.

| Field       | Type/Description |
| :---------- | :----------------
| `id`        | `Id` |
|             | The id of the asset to be decomposed. |
| `factors`   | `[` `Asset` `]` |
|             | The ids and amounts of assets to be created when decomposing one unit of the specified asset id. |
| `observers` | `Set` `Party` |



  #### Choices


### Template `AssetDeposit`

Represents a deposit of an asset in an account. The `account.id` and `asset.id` fields
can be used to link the contract to other contracts that provide further information
such as the type of the asset or reference data for it. This allows new asset classes
to be added without having to modify business processes that operate on generic
asset deposits.

| Field       | Type/Description |
| :---------- | :----------------
| `account`   | `Account` |
|             | A deposit is allocated to an account and backed by the account.id.signatories. Depending on the desired trust model this might be (i) both the provider and the owner, (ii) just the provider or (iii) a third party agent. |
| `asset`     | `Asset` |
|             | Specifies the id and the amount of assets deposited. The asset.id.signatories are the parties that publish reference data and hence the details for how to lifecycle the asset. |
| `observers` | `Set` `Party` |



  #### Choices

* `AssetDeposit_SetObservers`

  | Field          | Type/Description |
  | :------------- | :----------------
  | `newObservers` | `Set` `Party` |




# Module DA.Finance.Fact.Instrument.Entitlement



## Templates

### Template `Entitlement`

Reference data describing an asset that entitles the owner to receive the
underlying asset at the settlement date. Can be used to lifecycle asset
deposits, trades or dependent instruments.

| Field            | Type/Description |
| :--------------- | :----------------
| `id`             | `Id` |
|                  | The asset id of the entitlement. Depending on the trust model the signatories might be the issuer or a third party reference data provider such as Reuters. |
| `settlementDate` | `Date` |
|                  | The date on which the underlying asset gets paid. |
| `underlyingId`   | `Id` |
|                  | The id of the underlying asset that gets paid. |
| `observers`      | `Set` `Party` |



  #### Choices




# Module DA.Finance.Fact.Instrument.Equity



## Templates

### Template `EquityCashDividend`

Reference data describing an equity cash dividend. Can be used to
lifecycle asset deposits, trades or dependent instruments.

| Field            | Type/Description |
| :--------------- | :----------------
| `id`             | `Id` |
|                  | The asset id to which the dividend applies. Depending on the trust model the signatories might be the issuer or a third party reference data provider such as Reuters. |
| `exDate`         | `Date` |
|                  | The date on or after which a security is traded without the dividend. |
| `settlementDate` | `Date` |
|                  | The date on which the dividend gets paid. |
| `perShare`       | `Asset` |
|                  | The id and amount of the distributed assets per unit of equity. |
| `observers`      | `Set` `Party` |



  #### Choices


### Template `EquityStockSplit`

Reference data describing an equity stock split. Can be used to
lifecycle asset deposits, trades or dependent instruments.

| Field       | Type/Description |
| :---------- | :----------------
| `id`        | `Id` |
|             | The asset id to which the stock split applies. Depending on the trust model the signatories might be the issuer or a third party reference data provider such as Reuters. |
| `exDate`    | `Date` |
|             | The date on or after which the security is traded with the split applied. |
| `rFactor`   | `Decimal` |
|             | The factor through which the quantity has to be devided to obtain the new quantity. |
| `observers` | `Set` `Party` |



  #### Choices




# Module DA.Finance.Fact.Trade.Dvp



## Templates

### Template `Dvp`

A Delivery vs Payment trade is an obligation to exchange the payment assets against
the delivery assets at the agreed settlement date.

| Field             | Type/Description |
| :---------------- | :----------------
| `masterAgreement` | `MasterAgreement` |
|                   | A trade is allocated to a master agreement and backed by the masterAgreement.id.signatories. Depending on the desired trust model this might be both counterparties or a third party agent. |
| `tradeId`         | `Id` |
|                   | The identifier of the trade within the master agreement. The tradeId.signatories can be left empty. |
| `buyer`           | `Party` |
|                   | The buyer is the party that sends the payments and receives the deliveries. The seller is the other counterparty mentioned in the master agreement. |
| `status`          | `SettlementStatus` |
|                   | The settlement status of the trade. |
| `settlementDate`  | `Optional` `Date` |
|                   | The settlement date of the trade. None indicates instant settlement. |
| `payments`        | `[` `Asset` `]` |
|                   | The assets that need to be paid from the buyer to the seller. |
| `deliveries`      | `[` `Asset` `]` |
|                   | The assets that need to be delivered from the seller to the buyer. |
| `observers`       | `Set` `Party` |



  #### Choices




# Module DA.Finance.Rule.Asset



## Templates

### Template `AssetFungible`

Rule that allows to split and merge asset deposits in the specified account.

| Field       | Type/Description |
| :---------- | :----------------
| `account`   | `Account` |
|             | The account for which the rule can be used. |
| `observers` | `Set` `Party` |



  #### Choices

* `AssetFungible_Merge`
  Merges a list of asset deposits into one.

  | Field         | Type/Description |
  | :------------ | :----------------
  | `depositCids` | `[` `ContractId` `AssetDeposit` `]` |
  |               | The asset deposits that will be consumed. All fields except for the quantity need to match. |

* `AssetFungible_Split`
  Splits an asset deposit according to the provided list of quantities.

  | Field        | Type/Description |
  | :----------- | :----------------
  | `depositCid` | `ContractId` `AssetDeposit` |
  |              | The asset deposit that will be consumed. |
  | `quantities` | `[` `Decimal` `]` |
  |              | The quantities of the newly created asset deposits. The total quantity needs to match the quantity of the provided asset. |


### Template `AssetLifecycle`

Rule that allows to lifecycle asset deposits in the specified account according to
the provided asset decomposition data.

| Field       | Type/Description |
| :---------- | :----------------
| `account`   | `Account` |
|             | The account for which the rule can be used. |
| `observers` | `Set` `Party` |



  #### Choices

* `AssetLifecycle_Process`
  Allows the owner to lifecycle an asset deposit according to an asset
  decomposition published by the deposit.asset.id.signatories.

  | Field              | Type/Description |
  | :----------------- | :----------------
  | `depositCid`       | `ContractId` `AssetDeposit` |
  |                    | Asset deposit to be lifecycled. |
  | `decompositionCid` | `ContractId` `AssetDecomposition` |
  |                    | Asset decomposition describing the lifecycle effects. |


### Template `AssetSettlement`

Rule that allows to credit, debit or transfer asset deposits in the specified account.

| Field       | Type/Description |
| :---------- | :----------------
| `account`   | `Account` |
|             | The account for which the rule can be used. |
| `observers` | `Set` `Party` |



  #### Choices

* `AssetSettlement_Credit`
  Gives the owner the right to archive an asset deposit.

  | Field        | Type/Description |
  | :----------- | :----------------
  | `depositCid` | `ContractId` `AssetDeposit` |
  |              | The asset deposit that will be consumed. |

* `AssetSettlement_Debit`
  Gives the provider the right to create an asset deposit signed by the
  account.id.signatories.

  | Field   | Type/Description |
  | :------ | :----------------
  | `asset` | `Asset` |
  |         | The asset id and amount to be created. |

* `AssetSettlement_Debit_Signatories`
  Helper functions for the account.id.signatories to create an asset deposit
  signed by them.

  | Field   | Type/Description |
  | :------ | :----------------
  | `asset` | `Asset` |
  |         | The asset id and amount to be created. |

* `AssetSettlement_SetObservers`

  | Field          | Type/Description |
  | :------------- | :----------------
  | `newObservers` | `Set` `Party` |

* `AssetSettlement_Transfer`
  Gives the owner the right to transfer an asset deposit to a new owner.

  | Field                | Type/Description |
  | :------------------- | :----------------
  | `receiver`           | `Party` |
  |                      | The party to which the asset deposit will be transferred to. |
  | `depositCid`         | `ContractId` `AssetDeposit` |
  |                      | The asset deposit that will be consumed. |
  | `debitSettlementCid` | `ContractId` `AssetSettlement` |
  |                      | The settlement rule that allows to debit the new asset deposit in the receiver's account. |


### Template `AssetSettlementChain`

Helper contract that allows to allocate assets to and settle a chain
of transfer instructions.

| Field             | Type/Description |
| :---------------- | :----------------
| `masterAgreement` | `MasterAgreement` |
|                   | The master agreement to which the settlement chain applies. |
| `tradeId`         | `Id` |
|                   | The trade under the master agreement to which the settlement chain applies. |
| `asset`           | `Asset` |
|                   | The id and amount of the asset to be settled. |
| `steps`           | `[` `AssetSettlementStep` `]` |
|                   | The steps in the settlement chain. |
| `observers`       | `Set` `Party` |



  #### Choices

* `AssetSettlementChain_AllocateNext`
  Allocates an asset deposit to the next step of the settlement chain.

  | Field        | Type/Description |
  | :----------- | :----------------
  | `depositCid` | `ContractId` `AssetDeposit` |
  |              | Specifies the asset deposit contract to be allocated. |

* `AssetSettlementChain_Process`
  Processes a settlement chain by transferring all allocated asset deposits.

  (no fields)

* `AssetTransferAllocation_Archive`

  (no fields)




## Data Types

### `data` `AssetSettlementStep`

  Data describing a single step in a settlement chain.
* `AssetSettlementStep`

  | Field                 | Type/Description |
  | :-------------------- | :----------------
  | `sender`              | `Party` |
  |                       | The sender of an asset deposit. |
  | `receiver`            | `Party` |
  |                       | The receiver of an asset deposit. |
  | `depositCid`          | `Optional` `(` `ContractId` `AssetDeposit` `)` |
  |                       | The allocated asset deposit. |
  | `creditSettlementCid` | `ContractId` `AssetSettlement` |
  |                       | The settlement rule that allows the asset deposit to be credited to the sender. |
  | `debitSettlementCid`  | `ContractId` `AssetSettlement` |
  |                       | The settlement rule that allows the asset deposit to be debited to the receiver. |



# Module DA.Finance.Rule.Instrument.Entitlement



## Templates

### Template `EntitlementLifecycle`

Rule that helps with processing entitlements.

| Field         | Type/Description |
| :------------ | :----------------
| `signatories` | `Set` `Party` |
|               | Publishers of the entitlement reference data. |
| `observers`   | `Set` `Party` |



  #### Choices

* `EntitlementLifecycle_Process`
  Allows the entitlement.id.signatories to create an asset decomposition
  contract from the entitlement reference data.

  | Field            | Type/Description |
  | :--------------- | :----------------
  | `entitlementCid` | `ContractId` `Entitlement` |
  |                  | The provided entitlement reference data. |




# Module DA.Finance.Rule.Instrument.Equity



## Templates

### Template `EquityCashDividendLifecycle`

Rule that helps with processing equity cash dividends.

| Field         | Type/Description |
| :------------ | :----------------
| `signatories` | `Set` `Party` |
|               | Publishers of the dividend reference data. |
| `observers`   | `Set` `Party` |



  #### Choices

* `EquityCashDividendLifecycle_Process`
  Allows the dividend.id.signatories to create an entitlement instrument
  and an asset decomposition contract from the dividend reference data.

  | Field                | Type/Description |
  | :------------------- | :----------------
  | `dividendCid`        | `ContractId` `EquityCashDividend` |
  |                      | The provided dividend reference data. |
  | `entitlementIdLabel` | `Text` |
  |                      | A label for the entitlement instrument describing the dividend payment. |


### Template `EquityStockSplitLifecycle`

Rule that helps with processing equity stock splits.

| Field         | Type/Description |
| :------------ | :----------------
| `signatories` | `Set` `Party` |
|               | Publishers of the stock split reference data. |
| `observers`   | `Set` `Party` |



  #### Choices

* `EquityStockSplitLifecycle_Process`
  Allows the stockSplit.id.signatories to create an asset decomposition
  contract from the stock split reference data.

  | Field           | Type/Description |
  | :-------------- | :----------------
  | `stockSplitCid` | `ContractId` `EquityStockSplit` |
  |                 | The provided stock split reference data. |




## Data Types

### `data` `EquityCashDividendLifecycle_Process_Result`

  The outputs of the EquityCashDividendLifecycle_Process choice.
* `EquityCashDividendLifecycle_Process_Result`

  | Field              | Type/Description |
  | :----------------- | :----------------
  | `entitlementCid`   | `ContractId` `Entitlement` |
  |                    | Entitlement instrument describing the upcoming dividend payment. |
  | `decompositionCid` | `ContractId` `AssetDecomposition` |
  |                    | Asset decomposition describing the increase of the asset's version number and the creation of a separate dividend entitlement. |



# Module DA.Finance.Rule.Trade.Dvp



## Templates

### Template `DvpLifecycle`

Rule that allows to lifecycle a Dvp trade under the specified master agreement
according to the provided asset decomposition.

| Field             | Type/Description |
| :---------------- | :----------------
| `masterAgreement` | `MasterAgreement` |
|                   | The master agreement for which the rule can be used. |
| `observers`       | `Set` `Party` |



  #### Choices

* `DvpLifecycle_Process1`

  | Field   | Type/Description |
  | :------ | :----------------
  | `param` | `DvpLifecycle_Process_Param` |

* `DvpLifecycle_Process2`

  | Field   | Type/Description |
  | :------ | :----------------
  | `param` | `DvpLifecycle_Process_Param` |


### Template `DvpSettlement`

Rule that allows to settle a Dvp under the specified master agreement by providing
fully allocated settlement chains for each payment and delivery obligation.

| Field             | Type/Description |
| :---------------- | :----------------
| `masterAgreement` | `MasterAgreement` |
|                   | The master agreement for which the rule can be used. |
| `observers`       | `Set` `Party` |



  #### Choices

* `DvpSettlement_Process1`

  | Field   | Type/Description |
  | :------ | :----------------
  | `param` | `DvpSettlement_Process_Param` |

* `DvpSettlement_Process2`

  | Field   | Type/Description |
  | :------ | :----------------
  | `param` | `DvpSettlement_Process_Param` |




## Data Types

### `data` `DvpLifecycle_Process_Param`

  The input parameters of the DvpLifecycle_Process choices.
* `DvpLifecycle_Process_Param`

  | Field              | Type/Description |
  | :----------------- | :----------------
  | `dvpCid`           | `ContractId` `Dvp` |
  |                    | Dvp trade to be lifecycled. |
  | `decompositionCid` | `ContractId` `AssetDecomposition` |
  |                    | Asset decomposition describing the lifecycle effects. |

### `data` `DvpSettlement_Process_Param`

  The input parameters of the DvpSettlement_Process choices.
* `DvpSettlement_Process_Param`

  | Field               | Type/Description |
  | :------------------ | :----------------
  | `dvpCid`            | `ContractId` `Dvp` |
  |                     | Dvp trade to be settled |
  | `paymentChainCids`  | `[` `ContractId` `AssetSettlementChain` `]` |
  |                     | Fully allocated settlement chain for each payment asset |
  | `deliveryChainCids` | `[` `ContractId` `AssetSettlementChain` `]` |
  |                     | Fully allocated settlement chain for each delivery asset |

### `data` `DvpSettlement_Process_Result`

  The outputs of the DvpSettlement_Process choices.
* `DvpSettlement_Process_Result`

  | Field                 | Type/Description |
  | :-------------------- | :----------------
  | `dvpCid`              | `ContractId` `Dvp` |
  |                       | Settled Dvp trade |
  | `paymentDepositCids`  | `[` `[` `ContractId` `AssetDeposit` `]` `]` |
  |                       | Transferred asset deposits for each payment obligation |
  | `deliveryDepositCids` | `[` `[` `ContractId` `AssetDeposit` `]` `]` |
  |                       | Transferred asset deposits for each delivery obligation |



# Module DA.Finance.Types



## Data Types

### `data` `Account`

  A record that identifies an account. Also includes the account
  stakeholders because they cannot be looked up from another contract
  when specifying choice actors.
* `Account`

  | Field      | Type/Description |
  | :--------- | :----------------
  | `id`       | `Id` |
  |            | References an account via its id. Depending on the desired trust model, the signatories might be (i) both the provider and the owner, (ii) just the provider or (iii) a third party agent. |
  | `provider` | `Party` |
  |            | Allows to specify choices of the account provider. |
  | `owner`    | `Party` |
  |            | Allows to specify choices of the account owner. |

### `data` `Asset`

  A record that combines an asset id and quantity. Can be used to
  describe a quantified claim to an asset.
* `Asset`

  | Field      | Type/Description |
  | :--------- | :----------------
  | `id`       | `Id` |
  |            | The asset id. Depending on the trust model, the signatories might be the issuer or a third party reference data provider such as Reuters. |
  | `quantity` | `Decimal` |
  |            | The amount of assets with the specified id. |

### `data` `Id`

  A versioned identifier backed by a set of signatories. Can be used as
  a primary key or foreign key of a contract.
* `Id`

  | Field         | Type/Description |
  | :------------ | :----------------
  | `signatories` | `Set` `Party` |
  |               | The parties that need to sign a contract with this id and that are responsible to ensure primary key uniqueness. |
  | `label`       | `Text` |
  |               | A label that makes a contract unique for a given set of signatories. |
  | `version`     | `Int` |
  |               | Allows to model multiple revisions of the same contract. |

### `data` `MasterAgreement`

  A record that specifies a master agreement. Also includes the
  counterparties because they cannot be looked up from another contract
  when specifying choice actors.
* `MasterAgreement`

  | Field    | Type/Description |
  | :------- | :----------------
  | `id`     | `Id` |
  |          | References a master agreement via its id. Depending on the desired trust model, the signatories might be both counterparties or a third party agent. |
  | `party1` | `Party` |
  |          | Allows to specify choices of the first counterparty. |
  | `party2` | `Party` |
  |          | Allows to specify choices of the second counterparty. |

### `data` `SettlementStatus`

  An enum that captures the settlement status of a trade.
* `SettlementStatus_Pending`
  An active trade prior to settlement
* `SettlementStatus_Instructed`
  A trade that has been instructed for settlement
* `SettlementStatus_Settled`
  A trade that has been settled



# Module DA.Finance.Utils



## Data Types

### `type` `Lens s a`
    = `(` `s` `->` `a`, `a` `->` `s` `->` `s` `)`

  Hand-crafted lens functionality to view, update and modify nested record fields.



## Functions

* `&` : `a` `->` `a` `->` `b` `->` `b`  
  `&` is a reverse application operator. This provides notational convenience.
  Its precedence is one higher than that of the forward application operator `$`,
  which allows `&` to be nested in `$`.
* `fetchAndArchive` : `ContractId` `a` `->` `Update` `a`  
  Fetches a contract, archives it and returns its value.
* `assertOnOrAfterDateMsg` : `Text` `->` `Date` `->` `m` `(`  `)`  
  Checks that the ledger time is on or after the provided date.
* `mapOnce` : `a` `->` `Optional` `a` `->` `[` `a` `]` `->` `[` `a` `]`  
  Replaces the first element of a list for which the provided function returns Some x.
* `zipChecked` : `[` `a` `]` `->` `[` `b` `]` `->` `[` `(` `a`, `b` `)` `]`  
  Like zip but fails if the list lengths don't match
* `keys` : `Map` `k` `v` `->` `[` `k` `]`  
  Return all keys of the map in ascending order.
* `elems` : `Map` `k` `v` `->` `[` `v` `]`  
  Return all elements of the map in the ascending order of their keys.
* `!` : `Map` `k` `v` `->` `k` `->` `v`  
  Find the value at a key. Calls error when the element can not be found.
* `insertA` : `Map` `k` `v` `->` `k` `->` `m` `v` `->` `m` `(` `Map` `k` `v` `)`  
  Like map insert but takes an Action as value and returns the modified map as action.
* `~>>` : `Lens` `a` `b` `->` `Lens` `b` `c` `->` `Lens` `a` `c`  
  Lens composition.

