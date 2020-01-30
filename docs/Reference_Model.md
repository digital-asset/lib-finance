# <a name="module-da-finance-asset-1249"></a>Module DA.Finance.Asset

## Templates

<a name="type-da-finance-asset-assetdeposit-12895"></a>**template** [AssetDeposit](#type-da-finance-asset-assetdeposit-12895)

> Represents a deposit of an asset in an account. The `account.id` and `asset.id` fields
> can be used to link the contract to other contracts that provide further information
> such as the type of the asset or reference data for it. This allows new asset classes
> to be added without having to modify business processes that operate on generic
> asset deposits.
> 
> | Field                                           | Type                                            | Description |
> | :---------------------------------------------- | :---------------------------------------------- | :---------- |
> | account                                         | [Account](#type-da-finance-types-account-82184) | A deposit is allocated to an account and backed by the account.id.signatories. Depending on the desired trust model this might be (i) both the provider and the owner, (ii) just the provider or (iii) a third party agent. |
> | asset                                           | [Asset](#type-da-finance-types-asset-31119)     | Specifies the id and the amount of assets deposited. The asset.id.signatories are the parties that publish reference data and hence the details for how to lifecycle the asset. |
> | observers                                       | Set Party                                       |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice AssetDeposit\_Merge**
>   
>   Merges a list of asset deposits with the given one into one.
>   
>   | Field                                                                    | Type                                                                     | Description |
>   | :----------------------------------------------------------------------- | :----------------------------------------------------------------------- | :---------- |
>   | depositCids                                                              | \[ContractId [AssetDeposit](#type-da-finance-asset-assetdeposit-12895)\] | The asset deposits that will be consumed. All fields except for the quantity need to match. |
> 
> * **Choice AssetDeposit\_SetObservers**
>   
>   | Field        | Type         | Description |
>   | :----------- | :----------- | :---------- |
>   | newObservers | Set Party    |  |
> 
> * **Choice AssetDeposit\_Split**
>   
>   Splits an asset deposit according to the provided list of quantities.
>   
>   | Field                                                                                      | Type                                                                                       | Description |
>   | :----------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------- | :---------- |
>   | quantities                                                                                 | \[[Decimal](https://docs.daml.com/daml/reference/base.html#type-ghc-types-decimal-54602)\] | The quantities of the newly created asset deposits. The total quantity needs to be smaller or equal than the current quantity. If it does not add up, an asset deposit with the remainder is created. |

# <a name="module-da-finance-asset-lifecycle-41309"></a>Module DA.Finance.Asset.Lifecycle

## Templates

<a name="type-da-finance-asset-lifecycle-assetlifecyclerule-98465"></a>**template** [AssetLifecycleRule](#type-da-finance-asset-lifecycle-assetlifecyclerule-98465)

> Rule that allows to lifecycle deposits in a specified account.
> 
> | Field                                           | Type                                            | Description |
> | :---------------------------------------------- | :---------------------------------------------- | :---------- |
> | account                                         | [Account](#type-da-finance-types-account-82184) | The account for which the rule can be used. |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice AssetLifecycle\_Process**
>   
>   Allows the owner to lifecycle an asset deposit according to its lifecycle
>   effects published by the deposit.asset.id.signatories.
>   
>   | Field                                                                                  | Type                                                                                   | Description |
>   | :------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- | :---------- |
>   | lifecycleEffectsCid                                                                    | ContractId [LifecycleEffects](#type-da-finance-asset-lifecycle-lifecycleeffects-57175) | Asset lifecycle effects. |
>   | depositCid                                                                             | ContractId [AssetDeposit](#type-da-finance-asset-assetdeposit-12895)                   | The asset deposit that will be lifecycled. |
>   | consumingDepositCids                                                                   | \[ContractId [AssetDeposit](#type-da-finance-asset-assetdeposit-12895)\]               | The asset deposits that will be consumed as part of lifecycling the asset. |
>   | accountIds                                                                             | Optional \[[Id](#type-da-finance-types-id-77101)\]                                     | Optional list of account ids where the lifecycle effects end up in. |

<a name="type-da-finance-asset-lifecycle-lifecycleeffects-57175"></a>**template** [LifecycleEffects](#type-da-finance-asset-lifecycle-lifecycleeffects-57175)

> Describes the lifecycle effects of an asset deposit. Can be used to process
> corporate actions such as an equity cash dividend that increases the asset's
> version number and creates a separate entitlement.
> 
> | Field                                           | Type                                            | Description |
> | :---------------------------------------------- | :---------------------------------------------- | :---------- |
> | id                                              | [Id](#type-da-finance-types-id-77101)           | The id of the asset to be lifecycled. |
> | consuming                                       | \[[Asset](#type-da-finance-types-asset-31119)\] | The ids and amounts of assets to be consumed when lifecycleing one unit of the specified asset id. |
> | effects                                         | \[[Asset](#type-da-finance-types-asset-31119)\] | The ids and amounts of assets to be created when lifecycling one unit of the specified asset id. |
> | observers                                       | Set Party                                       |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice LifecycleEffects\_SetObservers**
>   
>   | Field        | Type         | Description |
>   | :----------- | :----------- | :---------- |
>   | newObservers | Set Party    |  |

# <a name="module-da-finance-asset-settlement-59417"></a>Module DA.Finance.Asset.Settlement

## Templates

<a name="type-da-finance-asset-settlement-assetsettlementrule-40609"></a>**template** [AssetSettlementRule](#type-da-finance-asset-settlement-assetsettlementrule-40609)

> Rule that allows to credit or transfer asset deposits
> in the specified account.
> 
> | Field                                           | Type                                            | Description |
> | :---------------------------------------------- | :---------------------------------------------- | :---------- |
> | account                                         | [Account](#type-da-finance-types-account-82184) | The account for which the rule can be used. |
> | observers                                       | Set Party                                       | Set of parties that will be added as observers when an asset is credited, i.e. an asset deposit is created. |
> | ctrls                                           | Set Party                                       | Set of parties who can act as a controller of the `AssetSettlement_Credit` choice. |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice AssetSettlement\_Credit**
>   
>   Allows a `ctrl` (if part of `ctrls`) to create an asset deposit.
>   The controller parties are the the account.id.signatories less account.owner
>   plus `ctrl` to guarantee that the choice can only be called from another choice
>   like the Transfer choice. The account.owner is removed from the controlling set
>   because his signature is in general not available.
>   
>   | Field                                       | Type                                        | Description |
>   | :------------------------------------------ | :------------------------------------------ | :---------- |
>   | asset                                       | [Asset](#type-da-finance-types-asset-31119) | The asset to be created. |
>   | ctrl                                        | Party                                       |  |
> 
> * **Choice AssetSettlement\_Debit**
>   
>   Gives the account.id.signatories the right to debit (i.e. archive)
>   an asset deposit.
>   
>   | Field                                                                | Type                                                                 | Description |
>   | :------------------------------------------------------------------- | :------------------------------------------------------------------- | :---------- |
>   | depositCid                                                           | ContractId [AssetDeposit](#type-da-finance-asset-assetdeposit-12895) | The asset deposit that will be consumed. |
> 
> * **Choice AssetSettlement\_Transfer**
>   
>   Gives the owner the right to transfer an asset deposit to a new owner.
>   Requires that the AssetSettlementRule of the receiver account is available
>   for use.
>   
>   | Field                                                                | Type                                                                 | Description |
>   | :------------------------------------------------------------------- | :------------------------------------------------------------------- | :---------- |
>   | receiverAccountId                                                    | [Id](#type-da-finance-types-id-77101)                                | The account id to which the asset deposit will be transferred to. |
>   | depositCid                                                           | ContractId [AssetDeposit](#type-da-finance-asset-assetdeposit-12895) | The asset deposit that will be consumed. |

# <a name="module-da-finance-base-holidaycalendar-45993"></a>Module DA.Finance.Base.HolidayCalendar

## Data Types

<a name="type-da-finance-base-holidaycalendar-businessdayadjustment-83293"></a>**data** [BusinessDayAdjustment](#type-da-finance-base-holidaycalendar-businessdayadjustment-83293)

> A data type to define how non-business days are adjusted.
> 
> <a name="constr-da-finance-base-holidaycalendar-businessdayadjustment-39902"></a>[BusinessDayAdjustment](#constr-da-finance-base-holidaycalendar-businessdayadjustment-39902)
> 
> > | Field                                                                                              | Type                                                                                               | Description |
> > | :------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------- | :---------- |
> > | calendarIds                                                                                        | \[[Text](https://docs.daml.com/daml/reference/base.html#type-ghc-types-text-57703)\]               | A list of calendar ids to define holidays. |
> > | convention                                                                                         | [BusinessDayConventionEnum](#type-da-finance-base-holidaycalendar-businessdayconventionenum-97226) | The business day convention used for the adjustment. |

<a name="type-da-finance-base-holidaycalendar-businessdayconventionenum-97226"></a>**data** [BusinessDayConventionEnum](#type-da-finance-base-holidaycalendar-businessdayconventionenum-97226)

> An enum type to specify how a non-business day is adjusted.
> 
> <a name="constr-da-finance-base-holidaycalendar-following-47506"></a>[FOLLOWING](#constr-da-finance-base-holidaycalendar-following-47506)
> 
> > Adjust a non-business day to the next business day.
> 
> <a name="constr-da-finance-base-holidaycalendar-modfollowing-25557"></a>[MODFOLLOWING](#constr-da-finance-base-holidaycalendar-modfollowing-25557)
> 
> > Adjust a non-business day to the next business day
> > unless it is not in the same month. In this case use
> > the previous business day.
> 
> <a name="constr-da-finance-base-holidaycalendar-modpreceding-9719"></a>[MODPRECEDING](#constr-da-finance-base-holidaycalendar-modpreceding-9719)
> 
> > Adjust a non-business day to the previous business day
> > unless it is not in the same month. In this case use
> > the next business day.
> 
> <a name="constr-da-finance-base-holidaycalendar-none-67142"></a>[NONE](#constr-da-finance-base-holidaycalendar-none-67142)
> 
> > Non-business days are not adjusted.
> 
> <a name="constr-da-finance-base-holidaycalendar-preceding-85852"></a>[PRECEDING](#constr-da-finance-base-holidaycalendar-preceding-85852)
> 
> > Adjust a non-business day to the previous business day.

<a name="type-da-finance-base-holidaycalendar-holidaycalendardata-54228"></a>**data** [HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228)

> Holiday Calendar Data used to define holidays.
> 
> <a name="constr-da-finance-base-holidaycalendar-holidaycalendardata-81623"></a>[HolidayCalendarData](#constr-da-finance-base-holidaycalendar-holidaycalendardata-81623)
> 
> > | Field                                                                            | Type                                                                             | Description |
> > | :------------------------------------------------------------------------------- | :------------------------------------------------------------------------------- | :---------- |
> > | id                                                                               | [Text](https://docs.daml.com/daml/reference/base.html#type-ghc-types-text-57703) | The id of the holiday calendar. |
> > | weekend                                                                          | \[DayOfWeek\]                                                                    | A list of week days defining the weekend. |
> > | holidays                                                                         | \[Date\]                                                                         | A list of dates defining holidays. |

## Functions

<a name="function-da-finance-base-holidaycalendar-merge-2732"></a>[merge](#function-da-finance-base-holidaycalendar-merge-2732)

> : \[[HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228)\] -\> [HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228)
> 
> Merge multiple holiday calendars into a single one. `id`s are concatenated by `,`.

<a name="function-da-finance-base-holidaycalendar-isholiday-8572"></a>[isHoliday](#function-da-finance-base-holidaycalendar-isholiday-8572)

> : [HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228) -\> Date -\> [Bool](https://docs.daml.com/daml/reference/base.html#type-ghc-types-bool-8654)
> 
> Check if Date is a holiday

<a name="function-da-finance-base-holidaycalendar-isbusinessday-91788"></a>[isBusinessDay](#function-da-finance-base-holidaycalendar-isbusinessday-91788)

> : [HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228) -\> Date -\> [Bool](https://docs.daml.com/daml/reference/base.html#type-ghc-types-bool-8654)
> 
> Check if Date is a business day

<a name="function-da-finance-base-holidaycalendar-nextbusinessday-62431"></a>[nextBusinessDay](#function-da-finance-base-holidaycalendar-nextbusinessday-62431)

> : [HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228) -\> Date -\> Date
> 
> Get next business day

<a name="function-da-finance-base-holidaycalendar-previousbusinessday-36967"></a>[previousBusinessDay](#function-da-finance-base-holidaycalendar-previousbusinessday-36967)

> : [HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228) -\> Date -\> Date
> 
> Get previous business day

<a name="function-da-finance-base-holidaycalendar-nextorsamebusinessday-73642"></a>[nextOrSameBusinessDay](#function-da-finance-base-holidaycalendar-nextorsamebusinessday-73642)

> : [HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228) -\> Date -\> Date
> 
> Get next or same business day

<a name="function-da-finance-base-holidaycalendar-previousorsamebusinessday-66938"></a>[previousOrSameBusinessDay](#function-da-finance-base-holidaycalendar-previousorsamebusinessday-66938)

> : [HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228) -\> Date -\> Date
> 
> Get previous or same business day

<a name="function-da-finance-base-holidaycalendar-nextsameorlastinmonthbusinessday-76632"></a>[nextSameOrLastInMonthBusinessDay](#function-da-finance-base-holidaycalendar-nextsameorlastinmonthbusinessday-76632)

> : [HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228) -\> Date -\> Date
> 
> Get next or same business day if before end of month. Otherwise get last business day in month.

<a name="function-da-finance-base-holidaycalendar-previoussameorfirstinmonthbusinessday-88027"></a>[previousSameOrFirstInMonthBusinessDay](#function-da-finance-base-holidaycalendar-previoussameorfirstinmonthbusinessday-88027)

> : [HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228) -\> Date -\> Date
> 
> Get previous or same business day if before end of month. Otherwise get first business day in month.

<a name="function-da-finance-base-holidaycalendar-addbusinessdays-3480"></a>[addBusinessDays](#function-da-finance-base-holidaycalendar-addbusinessdays-3480)

> : [HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228) -\> [Int](https://docs.daml.com/daml/reference/base.html#type-ghc-types-int-68728) -\> Date -\> Date
> 
> Add business days to a Date

<a name="function-da-finance-base-holidaycalendar-adjustdate-85974"></a>[adjustDate](#function-da-finance-base-holidaycalendar-adjustdate-85974)

> : [HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228) -\> [BusinessDayConventionEnum](#type-da-finance-base-holidaycalendar-businessdayconventionenum-97226) -\> Date -\> Date
> 
> Adjust date according to the given business day convention

# <a name="module-da-finance-base-rollconvention-57734"></a>Module DA.Finance.Base.RollConvention

## Data Types

<a name="type-da-finance-base-rollconvention-period-73275"></a>**data** [Period](#type-da-finance-base-rollconvention-period-73275)

> A data type to define periods.
> 
> <a name="constr-da-finance-base-rollconvention-period-69280"></a>[Period](#constr-da-finance-base-rollconvention-period-69280)
> 
> > | Field                                                                          | Type                                                                           | Description |
> > | :----------------------------------------------------------------------------- | :----------------------------------------------------------------------------- | :---------- |
> > | period                                                                         | [PeriodEnum](#type-da-finance-base-rollconvention-periodenum-21540)            | A period, e.g. a day, week, month or year. |
> > | periodMultiplier                                                               | [Int](https://docs.daml.com/daml/reference/base.html#type-ghc-types-int-68728) | A period multiplier, e.g. 1, 2 or 3 etc. |

<a name="type-da-finance-base-rollconvention-periodenum-21540"></a>**data** [PeriodEnum](#type-da-finance-base-rollconvention-periodenum-21540)

> An enum type to specify a period, e.g. day, week.
> 
> <a name="constr-da-finance-base-rollconvention-d-65848"></a>[D](#constr-da-finance-base-rollconvention-d-65848)
> 
> > Day
> 
> <a name="constr-da-finance-base-rollconvention-m-85213"></a>[M](#constr-da-finance-base-rollconvention-m-85213)
> 
> > Month
> 
> <a name="constr-da-finance-base-rollconvention-w-47027"></a>[W](#constr-da-finance-base-rollconvention-w-47027)
> 
> > Week
> 
> <a name="constr-da-finance-base-rollconvention-y-75281"></a>[Y](#constr-da-finance-base-rollconvention-y-75281)
> 
> > Year

<a name="type-da-finance-base-rollconvention-rollconventionenum-45455"></a>**data** [RollConventionEnum](#type-da-finance-base-rollconvention-rollconventionenum-45455)

> An enum type to specify how to roll dates.
> 
> <a name="constr-da-finance-base-rollconvention-eom-32947"></a>[EOM](#constr-da-finance-base-rollconvention-eom-32947)
> 
> > Rolls on month end.
> 
> <a name="constr-da-finance-base-rollconvention-dom-98282"></a>[DOM](#constr-da-finance-base-rollconvention-dom-98282) [Int](https://docs.daml.com/daml/reference/base.html#type-ghc-types-int-68728)
> 
> > Rolls on the corresponding day of the month.

## Functions

<a name="function-da-finance-base-rollconvention-next-77721"></a>[next](#function-da-finance-base-rollconvention-next-77721)

> : Date -\> [Period](#type-da-finance-base-rollconvention-period-73275) -\> [RollConventionEnum](#type-da-finance-base-rollconvention-rollconventionenum-45455) -\> Date
> 
> Get next periodic (daily `D` and weekly `W` not supported) date according
> to a given roll convention.

<a name="function-da-finance-base-rollconvention-previous-71765"></a>[previous](#function-da-finance-base-rollconvention-previous-71765)

> : Date -\> [Period](#type-da-finance-base-rollconvention-period-73275) -\> [RollConventionEnum](#type-da-finance-base-rollconvention-rollconventionenum-45455) -\> Date
> 
> Get previous periodic (daily `D` and weekly `W` not supported) date according
> to a given roll convention.

<a name="function-da-finance-base-rollconvention-addperiod-32307"></a>[addPeriod](#function-da-finance-base-rollconvention-addperiod-32307)

> : Date -\> [Period](#type-da-finance-base-rollconvention-period-73275) -\> Date
> 
> Add period to given date.

# <a name="module-da-finance-base-schedule-43337"></a>Module DA.Finance.Base.Schedule

## Data Types

<a name="type-da-finance-base-schedule-frequency-31970"></a>**data** [Frequency](#type-da-finance-base-schedule-frequency-31970)

> Frequency of a periodic schedule.
> 
> <a name="constr-da-finance-base-schedule-frequency-787"></a>[Frequency](#constr-da-finance-base-schedule-frequency-787)
> 
> > | Field                                                                               | Type                                                                                | Description |
> > | :---------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------- | :---------- |
> > | period                                                                              | [PeriodEnum](#type-da-finance-base-rollconvention-periodenum-21540)                 | The period, e.g. day, month, etc. |
> > | periodMultiplier                                                                    | [Int](https://docs.daml.com/daml/reference/base.html#type-ghc-types-int-68728)      | The period multiplier. |
> > | rollConvention                                                                      | [RollConventionEnum](#type-da-finance-base-rollconvention-rollconventionenum-45455) | The roll convention. |

<a name="type-da-finance-base-schedule-periodicschedule-84461"></a>**data** [PeriodicSchedule](#type-da-finance-base-schedule-periodicschedule-84461)

> A periodic schedule.
> 
> <a name="constr-da-finance-base-schedule-periodicschedule-29502"></a>[PeriodicSchedule](#constr-da-finance-base-schedule-periodicschedule-29502)
> 
> > | Field                                                                                               | Type                                                                                                | Description |
> > | :-------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------- | :---------- |
> > | effectiveDate                                                                                       | Date                                                                                                | Effective date, i.e. the (unadjusted) start date of the first period. |
> > | terminationDate                                                                                     | Date                                                                                                | Termination date, i.e. the (unadjusted) end date of the last period. |
> > | firstRegularPeriodStartDate                                                                         | Optional Date                                                                                       | The (unadjusted) start date of the first regular period (optional). |
> > | lastRegularPeriodEndDate                                                                            | Optional Date                                                                                       | The (unadjusted) end date of the last regular period (optional). |
> > | frequency                                                                                           | [Frequency](#type-da-finance-base-schedule-frequency-31970)                                         | The frequency of the periodic schedule. |
> > | businessDayAdjustment                                                                               | [BusinessDayAdjustment](#type-da-finance-base-holidaycalendar-businessdayadjustment-83293)          | The business day adjustment to determine adjusted dates. |
> > | effectiveDateBusinessDayAdjustment                                                                  | Optional [BusinessDayAdjustment](#type-da-finance-base-holidaycalendar-businessdayadjustment-83293) | The (optional) business day adjustment of the effective date |
> > | terminationDateBusinessDayAdjustment                                                                | Optional [BusinessDayAdjustment](#type-da-finance-base-holidaycalendar-businessdayadjustment-83293) | The (optional) business day adjustment of the termination date |
> > | stubPeriodType                                                                                      | Optional [StubPeriodTypeEnum](#type-da-finance-base-schedule-stubperiodtypeenum-25799)              | An optional stub to define a stub implicitly and not via `firstRegularPeriodStartDate` or `lastRegularPeriodEndDate`. |

<a name="type-da-finance-base-schedule-schedule-55338"></a>**type** [Schedule](#type-da-finance-base-schedule-schedule-55338)

> = \[[SchedulePeriod](#type-da-finance-base-schedule-scheduleperiod-46627)\]
> 
> A schedule defined by a list of periods.

<a name="type-da-finance-base-schedule-scheduleperiod-46627"></a>**data** [SchedulePeriod](#type-da-finance-base-schedule-scheduleperiod-46627)

> A single period in a schedule.
> 
> <a name="constr-da-finance-base-schedule-scheduleperiod-99788"></a>[SchedulePeriod](#constr-da-finance-base-schedule-scheduleperiod-99788)
> 
> > | Field               | Type                | Description |
> > | :------------------ | :------------------ | :---------- |
> > | adjustedEndDate     | Date                | Adjusted end date. |
> > | adjustedStartDate   | Date                | Adjusted start date. |
> > | unadjustedEndDate   | Date                | Unadjusted end date. |
> > | unadjustedStartDate | Date                | Unadjusted start date. |

<a name="type-da-finance-base-schedule-stubperiodtypeenum-25799"></a>**data** [StubPeriodTypeEnum](#type-da-finance-base-schedule-stubperiodtypeenum-25799)

> An enum type to specify a stub.
> 
> <a name="constr-da-finance-base-schedule-longfinal-703"></a>[LONG\_FINAL](#constr-da-finance-base-schedule-longfinal-703)
> 
> > A long (more than one period) final stub.
> 
> <a name="constr-da-finance-base-schedule-longinitial-87733"></a>[LONG\_INITIAL](#constr-da-finance-base-schedule-longinitial-87733)
> 
> > A long (more than one period) initial stub.
> 
> <a name="constr-da-finance-base-schedule-shortfinal-14540"></a>[SHORT\_FINAL](#constr-da-finance-base-schedule-shortfinal-14540)
> 
> > A short (less than one period) final stub.
> 
> <a name="constr-da-finance-base-schedule-shortinitial-12674"></a>[SHORT\_INITIAL](#constr-da-finance-base-schedule-shortinitial-12674)
> 
> > A short (less than one period) initial stub.

## Functions

<a name="function-da-finance-base-schedule-createschedule-12876"></a>[createSchedule](#function-da-finance-base-schedule-createschedule-12876)

> : \[[HolidayCalendarData](#type-da-finance-base-holidaycalendar-holidaycalendardata-54228)\] -\> [PeriodicSchedule](#type-da-finance-base-schedule-periodicschedule-84461) -\> [Schedule](#type-da-finance-base-schedule-schedule-55338)
> 
> Generate schedule from a periodic schedule.

# <a name="module-da-finance-instrument-entitlement-16986"></a>Module DA.Finance.Instrument.Entitlement

## Templates

<a name="type-da-finance-instrument-entitlement-entitlement-65474"></a>**template** [Entitlement](#type-da-finance-instrument-entitlement-entitlement-65474)

> Reference data describing an asset that entitles the owner to receive the
> underlying asset at the settlement date. Can be used to lifecycle asset
> deposits, trades or dependent instruments.
> 
> | Field                                                | Type                                                 | Description |
> | :--------------------------------------------------- | :--------------------------------------------------- | :---------- |
> | id                                                   | [Id](#type-da-finance-types-id-77101)                | The asset id of the entitlement. Depending on the trust model the signatories might be the issuer or a third party reference data provider such as Reuters. |
> | settlementDate                                       | Date                                                 | The date on which the underlying asset gets delivered. |
> | underlying                                           | [Asset](#type-da-finance-types-asset-31119)          | The id and quantity of the underlying asset that gets delivered. |
> | payment                                              | Optional [Asset](#type-da-finance-types-asset-31119) | The id and quantity of an asset that optionally needs to be paid to receive the underlying asset. |
> | observers                                            | Set Party                                            |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice Entitlement\_Lifecycle**
>   
>   Allows the id.signatories to create lifecycle effects.
>   
>   (no fields)
> 
> * **Choice Entitlement\_SetObservers**
>   
>   | Field        | Type         | Description |
>   | :----------- | :----------- | :---------- |
>   | newObservers | Set Party    |  |

# <a name="module-da-finance-instrument-equity-cashdividend-51866"></a>Module DA.Finance.Instrument.Equity.CashDividend

## Templates

<a name="type-da-finance-instrument-equity-cashdividend-equitycashdividend-89045"></a>**template** [EquityCashDividend](#type-da-finance-instrument-equity-cashdividend-equitycashdividend-89045)

> Reference data describing an equity cash dividend.
> 
> | Field                                                                                  | Type                                                                                   | Description |
> | :------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- | :---------- |
> | id                                                                                     | [Id](#type-da-finance-types-id-77101)                                                  | The stock asset id to which the dividend applies. Depending on the trust model the signatories might be the issuer or a third party reference data provider such as Reuters. |
> | exDate                                                                                 | Date                                                                                   | The date on or after which a security is traded without the dividend. |
> | settlementDate                                                                         | Date                                                                                   | The date on which the dividend gets paid. |
> | perShare                                                                               | [Decimal](https://docs.daml.com/daml/reference/base.html#type-ghc-types-decimal-54602) | The amount of the distributed assets per unit of equity. |
> | observers                                                                              | Set Party                                                                              |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice EquityCashDividend\_SetObservers**
>   
>   | Field        | Type         | Description |
>   | :----------- | :----------- | :---------- |
>   | newObservers | Set Party    |  |

# <a name="module-da-finance-instrument-equity-option-68293"></a>Module DA.Finance.Instrument.Equity.Option

## Templates

<a name="type-da-finance-instrument-equity-option-equityoption-21111"></a>**template** [EquityOption](#type-da-finance-instrument-equity-option-equityoption-21111)

> Reference data describing an equity option.
> 
> | Field                                                                                  | Type                                                                                   | Description |
> | :------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- | :---------- |
> | id                                                                                     | [Id](#type-da-finance-types-id-77101)                                                  | The option asset id. Depending on the trust model the signatories might be the issuer or a third party reference data provider such as Reuters. |
> | underlyingId                                                                           | [Id](#type-da-finance-types-id-77101)                                                  | The id of the underlying. |
> | optionType                                                                             | [OptionType](#type-da-finance-instrument-equity-option-optiontype-92244)               | The type of the option (PUT or CALL). |
> | exerciseType                                                                           | [ExerciseType](#type-da-finance-instrument-equity-option-exercisetype-88507)           | The type of the exercise style (EUROPEAN or AMERICAN). |
> | strike                                                                                 | [Decimal](https://docs.daml.com/daml/reference/base.html#type-ghc-types-decimal-54602) | The strike of the option. |
> | contractSize                                                                           | [Decimal](https://docs.daml.com/daml/reference/base.html#type-ghc-types-decimal-54602) | The contract size (i.e. multiplier) of the option. |
> | maturity                                                                               | Date                                                                                   | The maturity of the option. |
> | settlementType                                                                         | [SettlementType](#type-da-finance-instrument-equity-option-settlementtype-9794)        | The settlement type of the option (CASH or PHYSICAL). |
> | settlementLag                                                                          | [Int](https://docs.daml.com/daml/reference/base.html#type-ghc-types-int-68728)         | The settlement lag of the option in calendar days. |
> | observers                                                                              | Set Party                                                                              |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice EquityOption\_SetObservers**
>   
>   | Field        | Type         | Description |
>   | :----------- | :----------- | :---------- |
>   | newObservers | Set Party    |  |

## Data Types

<a name="type-da-finance-instrument-equity-option-exercisetype-88507"></a>**data** [ExerciseType](#type-da-finance-instrument-equity-option-exercisetype-88507)

> <a name="constr-da-finance-instrument-equity-option-european-83911"></a>[EUROPEAN](#constr-da-finance-instrument-equity-option-european-83911)
> 
> 
> <a name="constr-da-finance-instrument-equity-option-american-93202"></a>[AMERICAN](#constr-da-finance-instrument-equity-option-american-93202)
> 

<a name="type-da-finance-instrument-equity-option-optiontype-92244"></a>**data** [OptionType](#type-da-finance-instrument-equity-option-optiontype-92244)

> <a name="constr-da-finance-instrument-equity-option-put-15478"></a>[PUT](#constr-da-finance-instrument-equity-option-put-15478)
> 
> 
> <a name="constr-da-finance-instrument-equity-option-call-39052"></a>[CALL](#constr-da-finance-instrument-equity-option-call-39052)
> 

<a name="type-da-finance-instrument-equity-option-settlementtype-9794"></a>**data** [SettlementType](#type-da-finance-instrument-equity-option-settlementtype-9794)

> <a name="constr-da-finance-instrument-equity-option-cash-90813"></a>[CASH](#constr-da-finance-instrument-equity-option-cash-90813)
> 
> 
> <a name="constr-da-finance-instrument-equity-option-physical-81335"></a>[PHYSICAL](#constr-da-finance-instrument-equity-option-physical-81335)
> 

# <a name="module-da-finance-instrument-equity-option-lifecycle-15001"></a>Module DA.Finance.Instrument.Equity.Option.Lifecycle

## Templates

<a name="type-da-finance-instrument-equity-option-lifecycle-equityoptionexerciserule-6399"></a>**template** [EquityOptionExerciseRule](#type-da-finance-instrument-equity-option-lifecycle-equityoptionexerciserule-6399)

> Rule that helps with processing an option exercise.
> 
> For EUROPEAN options, exercise lifecycle effects are supposed
> to be created once at maturity. Option holder can use it to
> exercise their option positions at maturity.
> 
> For AMERICAN options, exercise lifecycle effects are supposed
> to be created according to the exercise schedule.
> 
> | Field       | Type        | Description |
> | :---------- | :---------- | :---------- |
> | signatories | Set Party   | Publishers of the option reference data. |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice EquityOptionExercise\_Lifecycle**
>   
>   Allows the signatories to create exercise
>   details for an option.
>   
>   | Field                                                                                           | Type                                                                                            | Description |
>   | :---------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------- | :---------- |
>   | optionCid                                                                                       | ContractId [EquityOption](#type-da-finance-instrument-equity-option-equityoption-21111)         | Option reference data. |
>   | underlyingPrice                                                                                 | Optional [Decimal](https://docs.daml.com/daml/reference/base.html#type-ghc-types-decimal-54602) | Price of the underlying in case of CASH settlement. |
>   | entitlementIdLabel                                                                              | [Text](https://docs.daml.com/daml/reference/base.html#type-ghc-types-text-57703)                | A label for the entitlement instrument describing the exercise. |

<a name="type-da-finance-instrument-equity-option-lifecycle-equityoptionstocksplitrule-61645"></a>**template** [EquityOptionStockSplitRule](#type-da-finance-instrument-equity-option-lifecycle-equityoptionstocksplitrule-61645)

> Rule that helps with processing stock splits for equity options.
> 
> | Field       | Type        | Description |
> | :---------- | :---------- | :---------- |
> | signatories | Set Party   | Publishers of the option reference data. |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice EquityOptionStockSplit\_Lifecycle**
>   
>   Allows the signatories to process stock split reference data
>   for a corresponding equity option.
>   
>   | Field                                                                                               | Type                                                                                                | Description |
>   | :-------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------- | :---------- |
>   | optionCid                                                                                           | ContractId [EquityOption](#type-da-finance-instrument-equity-option-equityoption-21111)             | The option to be lifecycled. |
>   | stockSplitCid                                                                                       | ContractId [EquityStockSplit](#type-da-finance-instrument-equity-stocksplit-equitystocksplit-53529) | Stock split reference data. |

## Data Types

<a name="type-da-finance-instrument-equity-option-lifecycle-equityoptionexerciseresult-63266"></a>**data** [EquityOptionExercise\_Result](#type-da-finance-instrument-equity-option-lifecycle-equityoptionexerciseresult-63266)

> The outputs of the EquityOptionExercise_Lifecycle choice.
> 
> <a name="constr-da-finance-instrument-equity-option-lifecycle-equityoptionexerciseresult-6717"></a>[EquityOptionExercise\_Result](#constr-da-finance-instrument-equity-option-lifecycle-equityoptionexerciseresult-6717)
> 
> > | Field                                                                                  | Type                                                                                   | Description |
> > | :------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- | :---------- |
> > | entitlementCid                                                                         | ContractId [Entitlement](#type-da-finance-instrument-entitlement-entitlement-65474)    | Entitlement instrument describing the option exercise. |
> > | lifecycleEffectsCid                                                                    | ContractId [LifecycleEffects](#type-da-finance-asset-lifecycle-lifecycleeffects-57175) | Lifecycle effects describing the archival of the option and the creation of an exercise entitlement. |

<a name="type-da-finance-instrument-equity-option-lifecycle-equityoptionstocksplitresult-23000"></a>**data** [EquityOptionStockSplit\_Result](#type-da-finance-instrument-equity-option-lifecycle-equityoptionstocksplitresult-23000)

> The outputs of the EquityOptionStockSplit_Lifecycle choice.
> 
> <a name="constr-da-finance-instrument-equity-option-lifecycle-equityoptionstocksplitresult-49695"></a>[EquityOptionStockSplit\_Result](#constr-da-finance-instrument-equity-option-lifecycle-equityoptionstocksplitresult-49695)
> 
> > | Field                                                                                   | Type                                                                                    | Description |
> > | :-------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------- | :---------- |
> > | optionCid                                                                               | ContractId [EquityOption](#type-da-finance-instrument-equity-option-equityoption-21111) | The option after applying the stock split. |
> > | lifecycleEffectsCid                                                                     | ContractId [LifecycleEffects](#type-da-finance-asset-lifecycle-lifecycleeffects-57175)  | Lifecycle effects describing the increase of the asset's version number. |

# <a name="module-da-finance-instrument-equity-stock-31605"></a>Module DA.Finance.Instrument.Equity.Stock

## Templates

<a name="type-da-finance-instrument-equity-stock-equitystock-61615"></a>**template** [EquityStock](#type-da-finance-instrument-equity-stock-equitystock-61615)

> Reference data describing an equity stock.
> 
> | Field                                 | Type                                  | Description |
> | :------------------------------------ | :------------------------------------ | :---------- |
> | id                                    | [Id](#type-da-finance-types-id-77101) | The stock asset id. Depending on the trust model the signatories might be the issuer or a third party reference data provider such as Reuters. |
> | ccy                                   | [Id](#type-da-finance-types-id-77101) |  |
> | observers                             | Set Party                             |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice EquityStock\_SetObservers**
>   
>   | Field        | Type         | Description |
>   | :----------- | :----------- | :---------- |
>   | newObservers | Set Party    |  |

# <a name="module-da-finance-instrument-equity-stock-lifecycle-70177"></a>Module DA.Finance.Instrument.Equity.Stock.Lifecycle

## Templates

<a name="type-da-finance-instrument-equity-stock-lifecycle-equitystockcashdividendrule-87917"></a>**template** [EquityStockCashDividendRule](#type-da-finance-instrument-equity-stock-lifecycle-equitystockcashdividendrule-87917)

> Rule that helps with processing equity cash dividends for stocks.
> 
> | Field       | Type        | Description |
> | :---------- | :---------- | :---------- |
> | signatories | Set Party   | Publishers of the dividend reference data. |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice EquityStockCashDividend\_Lifecycle**
>   
>   Allows the signatories to process dividend reference data
>   for the corresponding stock.
>   
>   | Field                                                                                                     | Type                                                                                                      | Description |
>   | :-------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------- | :---------- |
>   | dividendCid                                                                                               | ContractId [EquityCashDividend](#type-da-finance-instrument-equity-cashdividend-equitycashdividend-89045) | Dividend reference data. |
>   | entitlementIdLabel                                                                                        | [Text](https://docs.daml.com/daml/reference/base.html#type-ghc-types-text-57703)                          | A label for the entitlement instrument describing the dividend payment. |

<a name="type-da-finance-instrument-equity-stock-lifecycle-equitystocksplitrule-39000"></a>**template** [EquityStockSplitRule](#type-da-finance-instrument-equity-stock-lifecycle-equitystocksplitrule-39000)

> Rule that helps with processing stock splits for stocks.
> 
> | Field       | Type        | Description |
> | :---------- | :---------- | :---------- |
> | signatories | Set Party   | Publishers of the stock split reference data. |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice EquityStockSplit\_Lifecycle**
>   
>   Allows the signatories to process stock split reference data
>   for the corresponding stock.
>   
>   | Field                                                                                               | Type                                                                                                | Description |
>   | :-------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------- | :---------- |
>   | stockSplitCid                                                                                       | ContractId [EquityStockSplit](#type-da-finance-instrument-equity-stocksplit-equitystocksplit-53529) | Stock split reference data. |

## Data Types

<a name="type-da-finance-instrument-equity-stock-lifecycle-equitystockcashdividendresult-97696"></a>**data** [EquityStockCashDividend\_Result](#type-da-finance-instrument-equity-stock-lifecycle-equitystockcashdividendresult-97696)

> The outputs of the EquityStockCashDividend_Lifecycle choice.
> 
> <a name="constr-da-finance-instrument-equity-stock-lifecycle-equitystockcashdividendresult-47599"></a>[EquityStockCashDividend\_Result](#constr-da-finance-instrument-equity-stock-lifecycle-equitystockcashdividendresult-47599)
> 
> > | Field                                                                                  | Type                                                                                   | Description |
> > | :------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- | :---------- |
> > | stockCid                                                                               | ContractId [EquityStock](#type-da-finance-instrument-equity-stock-equitystock-61615)   | The stock ex-dividend with increased version. |
> > | entitlementCid                                                                         | ContractId [Entitlement](#type-da-finance-instrument-entitlement-entitlement-65474)    | Entitlement instrument describing the upcoming dividend payment. |
> > | lifecycleEffectsCid                                                                    | ContractId [LifecycleEffects](#type-da-finance-asset-lifecycle-lifecycleeffects-57175) | Lifecycle effects describing the increase of the asset's version number and the creation of a separate dividend entitlement. |

<a name="type-da-finance-instrument-equity-stock-lifecycle-equitystocksplitresult-29171"></a>**data** [EquityStockSplit\_Result](#type-da-finance-instrument-equity-stock-lifecycle-equitystocksplitresult-29171)

> The outputs of the EquityStockSplit_Lifecycle choice.
> 
> <a name="constr-da-finance-instrument-equity-stock-lifecycle-equitystocksplitresult-50778"></a>[EquityStockSplit\_Result](#constr-da-finance-instrument-equity-stock-lifecycle-equitystocksplitresult-50778)
> 
> > | Field                                                                                  | Type                                                                                   | Description |
> > | :------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- | :---------- |
> > | stockCid                                                                               | ContractId [EquityStock](#type-da-finance-instrument-equity-stock-equitystock-61615)   | The stock after applying the stock split with increased version number. |
> > | lifecycleEffectsCid                                                                    | ContractId [LifecycleEffects](#type-da-finance-asset-lifecycle-lifecycleeffects-57175) | Lifecycle effects describing the increase of the asset's version number. |

# <a name="module-da-finance-instrument-equity-stocksplit-32034"></a>Module DA.Finance.Instrument.Equity.StockSplit

## Templates

<a name="type-da-finance-instrument-equity-stocksplit-equitystocksplit-53529"></a>**template** [EquityStockSplit](#type-da-finance-instrument-equity-stocksplit-equitystocksplit-53529)

> Reference data describing an equity stock split.
> 
> | Field                                                                                  | Type                                                                                   | Description |
> | :------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- | :---------- |
> | id                                                                                     | [Id](#type-da-finance-types-id-77101)                                                  | The asset id to which the stock split applies. Depending on the trust model the signatories might be the issuer or a third party reference data provider such as Reuters. |
> | exDate                                                                                 | Date                                                                                   | The date on or after which the security is traded with the split applied. |
> | rFactor                                                                                | [Decimal](https://docs.daml.com/daml/reference/base.html#type-ghc-types-decimal-54602) | The factor through which the quantity has to be divided to obtain the new quantity. |
> | observers                                                                              | Set Party                                                                              |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice EquityStockSplit\_SetObservers**
>   
>   | Field        | Type         | Description |
>   | :----------- | :----------- | :---------- |
>   | newObservers | Set Party    |  |

# <a name="module-da-finance-trade-dvp-5355"></a>Module DA.Finance.Trade.Dvp

## Templates

<a name="type-da-finance-trade-dvp-dvp-34338"></a>**template** [Dvp](#type-da-finance-trade-dvp-dvp-34338)

> A Delivery vs Payment trade is an obligation to exchange the payment assets against
> the delivery assets at the agreed settlement date.
> 
> | Field                                                                   | Type                                                                    | Description |
> | :---------------------------------------------------------------------- | :---------------------------------------------------------------------- | :---------- |
> | masterAgreement                                                         | [MasterAgreement](#type-da-finance-types-masteragreement-56639)         | A trade is allocated to a master agreement and backed by the masterAgreement.id.signatories. Depending on the desired trust model this might be both counterparties or a third party agent. |
> | tradeId                                                                 | [Id](#type-da-finance-types-id-77101)                                   | The identifier of the trade within the master agreement. The tradeId.signatories can be left empty. |
> | buyer                                                                   | Party                                                                   | The buyer is the party that sends the payments and receives the deliveries. The seller is the other counterparty mentioned in the master agreement. |
> | status                                                                  | [SettlementStatus](#type-da-finance-trade-types-settlementstatus-75221) | The settlement status of the trade. |
> | settlementDate                                                          | Optional Date                                                           | The settlement date of the trade. None indicates instant settlement. |
> | payments                                                                | \[[Asset](#type-da-finance-types-asset-31119)\]                         | The assets that need to be paid from the buyer to the seller. |
> | deliveries                                                              | \[[Asset](#type-da-finance-types-asset-31119)\]                         | The assets that need to be delivered from the seller to the buyer. |
> | observers                                                               | Set Party                                                               |  |
> 
> * **Choice Archive**
>   
>   (no fields)

# <a name="module-da-finance-trade-dvp-lifecycle-80859"></a>Module DA.Finance.Trade.Dvp.Lifecycle

## Templates

<a name="type-da-finance-trade-dvp-lifecycle-dvplifecyclerule-97795"></a>**template** [DvpLifecycleRule](#type-da-finance-trade-dvp-lifecycle-dvplifecyclerule-97795)

> Rule that allows to lifecycle a Dvp trade under the specified master agreement
> according to the provided lifecycle effects.
> 
> | Field                                                           | Type                                                            | Description |
> | :-------------------------------------------------------------- | :-------------------------------------------------------------- | :---------- |
> | masterAgreement                                                 | [MasterAgreement](#type-da-finance-types-masteragreement-56639) | The master agreement for which the rule can be used. |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice DvpLifecycle\_Process**
>   
>   | Field                                                                                  | Type                                                                                   | Description |
>   | :------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- | :---------- |
>   | dvpCid                                                                                 | ContractId [Dvp](#type-da-finance-trade-dvp-dvp-34338)                                 | Dvp trade to be lifecycled. |
>   | lifecycleEffectsCid                                                                    | ContractId [LifecycleEffects](#type-da-finance-asset-lifecycle-lifecycleeffects-57175) | Asset lifecycle effects. |
>   | ctrl                                                                                   | Party                                                                                  | masterAgreement.party1 or masterAgreement.party2 |

# <a name="module-da-finance-trade-dvp-settlement-35655"></a>Module DA.Finance.Trade.Dvp.Settlement

## Templates

<a name="type-da-finance-trade-dvp-settlement-dvpsettlementrule-78851"></a>**template** [DvpSettlementRule](#type-da-finance-trade-dvp-settlement-dvpsettlementrule-78851)

> Rule that allows to settle a Dvp under the specified master agreement by providing
> fully allocated settlement instructions for each payment and delivery obligation.
> 
> | Field                                                           | Type                                                            | Description |
> | :-------------------------------------------------------------- | :-------------------------------------------------------------- | :---------- |
> | masterAgreement                                                 | [MasterAgreement](#type-da-finance-types-masteragreement-56639) | The master agreement for which the rule can be used. |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice DvpSettlement\_Process**
>   
>   | Field                                                                                                            | Type                                                                                                             | Description |
>   | :--------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------- | :---------- |
>   | dvpCid                                                                                                           | ContractId [Dvp](#type-da-finance-trade-dvp-dvp-34338)                                                           | Dvp trade to be settled |
>   | paymentInstructionCids                                                                                           | \[ContractId [SettlementInstruction](#type-da-finance-trade-settlementinstruction-settlementinstruction-60726)\] | Fully allocated settlement instruction for each payment asset. |
>   | deliveryInstructionCids                                                                                          | \[ContractId [SettlementInstruction](#type-da-finance-trade-settlementinstruction-settlementinstruction-60726)\] | Fully allocated settlement instruction for each delivery asset. |
>   | ctrl                                                                                                             | Party                                                                                                            | masterAgreement.party1 or masterAgreement.party2 |

## Data Types

<a name="type-da-finance-trade-dvp-settlement-dvpsettlementprocessresult-79056"></a>**data** [DvpSettlement\_Process\_Result](#type-da-finance-trade-dvp-settlement-dvpsettlementprocessresult-79056)

> The outputs of the DvpSettlement_Process choice.
> 
> <a name="constr-da-finance-trade-dvp-settlement-dvpsettlementprocessresult-73841"></a>[DvpSettlement\_Process\_Result](#constr-da-finance-trade-dvp-settlement-dvpsettlementprocessresult-73841)
> 
> > | Field                                                                        | Type                                                                         | Description |
> > | :--------------------------------------------------------------------------- | :--------------------------------------------------------------------------- | :---------- |
> > | dvpCid                                                                       | ContractId [Dvp](#type-da-finance-trade-dvp-dvp-34338)                       | Settled Dvp trade |
> > | paymentDepositCids                                                           | \[\[ContractId [AssetDeposit](#type-da-finance-asset-assetdeposit-12895)\]\] | Transferred asset deposits for each payment obligation |
> > | deliveryDepositCids                                                          | \[\[ContractId [AssetDeposit](#type-da-finance-asset-assetdeposit-12895)\]\] | Transferred asset deposits for each delivery obligation |

# <a name="module-da-finance-trade-settlementinstruction-54514"></a>Module DA.Finance.Trade.SettlementInstruction

## Templates

<a name="type-da-finance-trade-settlementinstruction-settlementinstruction-60726"></a>**template** [SettlementInstruction](#type-da-finance-trade-settlementinstruction-settlementinstruction-60726)

> Represents a settlement instruction for a specific trade. It is typically
> created at the same time than the trade is instructed. Allows to allocate assets
> and, once done, settle the instruction.
> If both counterparties have an account with the same provider, a single step,
> i.e. a direct transfer, suffices. If assets need to be atomically transferred up
> and down an account hierarchy, then multiple steps are required.
> 
> | Field                                                                                         | Type                                                                                          | Description |
> | :-------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------- | :---------- |
> | masterAgreement                                                                               | [MasterAgreement](#type-da-finance-types-masteragreement-56639)                               | The master agreement to which the settlement applies. |
> | tradeId                                                                                       | [Id](#type-da-finance-types-id-77101)                                                         | The trade under the master agreement to which the settlement applies. |
> | asset                                                                                         | [Asset](#type-da-finance-types-asset-31119)                                                   | The id and amount of the asset to be settled. |
> | steps                                                                                         | \[[SettlementDetails](#type-da-finance-trade-settlementinstruction-settlementdetails-61668)\] | The steps in the settlement. If both counterparties have an account with the same provider, a single step, i.e. a direct transfer, suffices. |
> | observers                                                                                     | Set Party                                                                                     |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice SettlementInstruction\_AllocateNext**
>   
>   Allocates an asset deposit to the next step of the settlement instruction.
>   In the simple case where both counterparties have an account with the same provider
>   a single allocation by the sender party is required.
>   
>   | Field                                                                | Type                                                                 | Description |
>   | :------------------------------------------------------------------- | :------------------------------------------------------------------- | :---------- |
>   | depositCid                                                           | ContractId [AssetDeposit](#type-da-finance-asset-assetdeposit-12895) | Specifies the asset deposit contract to be allocated. |
>   | ctrl                                                                 | Party                                                                | The next sender. |
> 
> * **Choice SettlementInstruction\_Archive**
>   
>   (no fields)
> 
> * **Choice SettlementInstruction\_Process**
>   
>   Processes a settlement instruction by transferring all allocated asset deposits.
>   This choice is often called from the trade itself to atomically settle all
>   assets involved.
>   
>   (no fields)

## Data Types

<a name="type-da-finance-trade-settlementinstruction-settlementdetails-61668"></a>**data** [SettlementDetails](#type-da-finance-trade-settlementinstruction-settlementdetails-61668)

> Data describing settlement details.
> 
> <a name="constr-da-finance-trade-settlementinstruction-settlementdetails-99421"></a>[SettlementDetails](#constr-da-finance-trade-settlementinstruction-settlementdetails-99421)
> 
> > | Field                                                                           | Type                                                                            | Description |
> > | :------------------------------------------------------------------------------ | :------------------------------------------------------------------------------ | :---------- |
> > | senderAccount                                                                   | [Account](#type-da-finance-types-account-82184)                                 | The sender account. |
> > | receiverAccount                                                                 | [Account](#type-da-finance-types-account-82184)                                 | The receiver account. |
> > | depositCid                                                                      | Optional (ContractId [AssetDeposit](#type-da-finance-asset-assetdeposit-12895)) | The allocated asset deposit. |

# <a name="module-da-finance-trade-types-82890"></a>Module DA.Finance.Trade.Types

## Data Types

<a name="type-da-finance-trade-types-settlementstatus-75221"></a>**data** [SettlementStatus](#type-da-finance-trade-types-settlementstatus-75221)

> An enum that captures the settlement status of a trade.
> 
> <a name="constr-da-finance-trade-types-settlementstatuspending-40382"></a>[SettlementStatus\_Pending](#constr-da-finance-trade-types-settlementstatuspending-40382)
> 
> > An active trade prior to settlement
> 
> <a name="constr-da-finance-trade-types-settlementstatusinstructed-9905"></a>[SettlementStatus\_Instructed](#constr-da-finance-trade-types-settlementstatusinstructed-9905)
> 
> > A trade that has been instructed for settlement
> 
> <a name="constr-da-finance-trade-types-settlementstatussettled-65000"></a>[SettlementStatus\_Settled](#constr-da-finance-trade-types-settlementstatussettled-65000)
> 
> > A trade that has been settled

# <a name="module-da-finance-types-98964"></a>Module DA.Finance.Types

## Data Types

<a name="type-da-finance-types-account-82184"></a>**data** [Account](#type-da-finance-types-account-82184)

> A record that identifies an account. Also includes the account
> stakeholders because they cannot be looked up from another contract
> when specifying choice actors.
> 
> <a name="constr-da-finance-types-account-43277"></a>[Account](#constr-da-finance-types-account-43277)
> 
> > | Field                                 | Type                                  | Description |
> > | :------------------------------------ | :------------------------------------ | :---------- |
> > | id                                    | [Id](#type-da-finance-types-id-77101) | References an account via its id. Depending on the desired trust model, the signatories might be (i) both the provider and the owner, (ii) just the provider or (iii) a third party agent. |
> > | provider                              | Party                                 | Allows to specify choices of the account provider. |
> > | owner                                 | Party                                 | Allows to specify choices of the account owner. |

<a name="type-da-finance-types-asset-31119"></a>**data** [Asset](#type-da-finance-types-asset-31119)

> A record that combines an asset id and quantity. Can be used to
> describe a quantified claim to an asset.
> 
> <a name="constr-da-finance-types-asset-33686"></a>[Asset](#constr-da-finance-types-asset-33686)
> 
> > | Field                                                                                  | Type                                                                                   | Description |
> > | :------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- | :---------- |
> > | id                                                                                     | [Id](#type-da-finance-types-id-77101)                                                  | The asset id. Depending on the trust model, the signatories might be the issuer or a third party reference data provider such as Reuters. |
> > | quantity                                                                               | [Decimal](https://docs.daml.com/daml/reference/base.html#type-ghc-types-decimal-54602) | The amount of assets with the specified id. |

<a name="type-da-finance-types-id-77101"></a>**data** [Id](#type-da-finance-types-id-77101)

> A versioned identifier backed by a set of signatories. Can be used as
> a primary key or foreign key of a contract.
> 
> <a name="constr-da-finance-types-id-66218"></a>[Id](#constr-da-finance-types-id-66218)
> 
> > | Field                                                                            | Type                                                                             | Description |
> > | :------------------------------------------------------------------------------- | :------------------------------------------------------------------------------- | :---------- |
> > | signatories                                                                      | Set Party                                                                        | The parties that need to sign a contract with this id and that are responsible to ensure primary key uniqueness. |
> > | label                                                                            | [Text](https://docs.daml.com/daml/reference/base.html#type-ghc-types-text-57703) | A label that makes a contract unique for a given set of signatories. |
> > | version                                                                          | [Int](https://docs.daml.com/daml/reference/base.html#type-ghc-types-int-68728)   | Allows to model multiple revisions of the same contract. |

<a name="type-da-finance-types-masteragreement-56639"></a>**data** [MasterAgreement](#type-da-finance-types-masteragreement-56639)

> A record that specifies a master agreement. Also includes the
> counterparties because they cannot be looked up from another contract
> when specifying choice actors.
> 
> <a name="constr-da-finance-types-masteragreement-66642"></a>[MasterAgreement](#constr-da-finance-types-masteragreement-66642)
> 
> > | Field                                 | Type                                  | Description |
> > | :------------------------------------ | :------------------------------------ | :---------- |
> > | id                                    | [Id](#type-da-finance-types-id-77101) | References a master agreement via its id. Depending on the desired trust model, the signatories might be both counterparties or a third party agent. |
> > | party1                                | Party                                 | Allows to specify choices of the first counterparty. |
> > | party2                                | Party                                 | Allows to specify choices of the second counterparty. |
