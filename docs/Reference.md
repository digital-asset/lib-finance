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

# <a name="module-da-finance-fact-asset-32086"></a>Module DA.Finance.Fact.Asset

## Templates

<a name="type-da-finance-fact-asset-assetdecomposition-49641"></a>**template** [AssetDecomposition](#type-da-finance-fact-asset-assetdecomposition-49641)

> Describes a decomposition of one asset into n other assets and the corresponding
> scaling factors. Can be used to process corporate actions such as an equity cash
> dividend that increases the asset's version number and creates a separate entitlement.
> 
> | Field                                           | Type                                            | Description |
> | :---------------------------------------------- | :---------------------------------------------- | :---------- |
> | id                                              | [Id](#type-da-finance-types-id-77101)           | The id of the asset to be decomposed. |
> | factors                                         | \[[Asset](#type-da-finance-types-asset-31119)\] | The ids and amounts of assets to be created when decomposing one unit of the specified asset id. |
> | observers                                       | Set Party                                       |  |
> 
> * **Choice Archive**
>   
>   (no fields)

<a name="type-da-finance-fact-asset-assetdeposit-59560"></a>**template** [AssetDeposit](#type-da-finance-fact-asset-assetdeposit-59560)

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
> * **Choice AssetDeposit\_SetObservers**
>   
>   | Field        | Type         | Description |
>   | :----------- | :----------- | :---------- |
>   | newObservers | Set Party    |  |

# <a name="module-da-finance-fact-instrument-entitlement-7795"></a>Module DA.Finance.Fact.Instrument.Entitlement

## Templates

<a name="type-da-finance-fact-instrument-entitlement-entitlement-97017"></a>**template** [Entitlement](#type-da-finance-fact-instrument-entitlement-entitlement-97017)

> Reference data describing an asset that entitles the owner to receive the
> underlying asset at the settlement date. Can be used to lifecycle asset
> deposits, trades or dependent instruments.
> 
> | Field                                 | Type                                  | Description |
> | :------------------------------------ | :------------------------------------ | :---------- |
> | id                                    | [Id](#type-da-finance-types-id-77101) | The asset id of the entitlement. Depending on the trust model the signatories might be the issuer or a third party reference data provider such as Reuters. |
> | settlementDate                        | Date                                  | The date on which the underlying asset gets paid. |
> | underlyingId                          | [Id](#type-da-finance-types-id-77101) | The id of the underlying asset that gets paid. |
> | observers                             | Set Party                             |  |
> 
> * **Choice Archive**
>   
>   (no fields)

# <a name="module-da-finance-fact-instrument-equity-63340"></a>Module DA.Finance.Fact.Instrument.Equity

## Templates

<a name="type-da-finance-fact-instrument-equity-equitycashdividend-88187"></a>**template** [EquityCashDividend](#type-da-finance-fact-instrument-equity-equitycashdividend-88187)

> Reference data describing an equity cash dividend. Can be used to
> lifecycle asset deposits, trades or dependent instruments.
> 
> | Field                                       | Type                                        | Description |
> | :------------------------------------------ | :------------------------------------------ | :---------- |
> | id                                          | [Id](#type-da-finance-types-id-77101)       | The asset id to which the dividend applies. Depending on the trust model the signatories might be the issuer or a third party reference data provider such as Reuters. |
> | exDate                                      | Date                                        | The date on or after which a security is traded without the dividend. |
> | settlementDate                              | Date                                        | The date on which the dividend gets paid. |
> | perShare                                    | [Asset](#type-da-finance-types-asset-31119) | The id and amount of the distributed assets per unit of equity. |
> | observers                                   | Set Party                                   |  |
> 
> * **Choice Archive**
>   
>   (no fields)

<a name="type-da-finance-fact-instrument-equity-equitystocksplit-99575"></a>**template** [EquityStockSplit](#type-da-finance-fact-instrument-equity-equitystocksplit-99575)

> Reference data describing an equity stock split. Can be used to
> lifecycle asset deposits, trades or dependent instruments.
> 
> | Field                                                                                  | Type                                                                                   | Description |
> | :------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- | :---------- |
> | id                                                                                     | [Id](#type-da-finance-types-id-77101)                                                  | The asset id to which the stock split applies. Depending on the trust model the signatories might be the issuer or a third party reference data provider such as Reuters. |
> | exDate                                                                                 | Date                                                                                   | The date on or after which the security is traded with the split applied. |
> | rFactor                                                                                | [Decimal](https://docs.daml.com/daml/reference/base.html#type-ghc-types-decimal-54602) | The factor through which the quantity has to be devided to obtain the new quantity. |
> | observers                                                                              | Set Party                                                                              |  |
> 
> * **Choice Archive**
>   
>   (no fields)

# <a name="module-da-finance-fact-trade-dvp-95932"></a>Module DA.Finance.Fact.Trade.Dvp

## Templates

<a name="type-da-finance-fact-trade-dvp-dvp-78355"></a>**template** [Dvp](#type-da-finance-fact-trade-dvp-dvp-78355)

> A Delivery vs Payment trade is an obligation to exchange the payment assets against
> the delivery assets at the agreed settlement date.
> 
> | Field                                                            | Type                                                             | Description |
> | :--------------------------------------------------------------- | :--------------------------------------------------------------- | :---------- |
> | masterAgreement                                                  | [MasterAgreement](#type-da-finance-types-masteragreement-56639)  | A trade is allocated to a master agreement and backed by the masterAgreement.id.signatories. Depending on the desired trust model this might be both counterparties or a third party agent. |
> | tradeId                                                          | [Id](#type-da-finance-types-id-77101)                            | The identifier of the trade within the master agreement. The tradeId.signatories can be left empty. |
> | buyer                                                            | Party                                                            | The buyer is the party that sends the payments and receives the deliveries. The seller is the other counterparty mentioned in the master agreement. |
> | status                                                           | [SettlementStatus](#type-da-finance-types-settlementstatus-8447) | The settlement status of the trade. |
> | settlementDate                                                   | Optional Date                                                    | The settlement date of the trade. None indicates instant settlement. |
> | payments                                                         | \[[Asset](#type-da-finance-types-asset-31119)\]                  | The assets that need to be paid from the buyer to the seller. |
> | deliveries                                                       | \[[Asset](#type-da-finance-types-asset-31119)\]                  | The assets that need to be delivered from the seller to the buyer. |
> | observers                                                        | Set Party                                                        |  |
> 
> * **Choice Archive**
>   
>   (no fields)

# <a name="module-da-finance-rule-asset-38526"></a>Module DA.Finance.Rule.Asset

## Templates

<a name="type-da-finance-rule-asset-assetfungible-29767"></a>**template** [AssetFungible](#type-da-finance-rule-asset-assetfungible-29767)

> Rule that allows to split and merge asset deposits in the specified account.
> 
> | Field                                           | Type                                            | Description |
> | :---------------------------------------------- | :---------------------------------------------- | :---------- |
> | account                                         | [Account](#type-da-finance-types-account-82184) | The account for which the rule can be used. |
> | observers                                       | Set Party                                       |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice AssetFungible\_Merge**
>   
>   Merges a list of asset deposits into one.
>   
>   | Field                                                                         | Type                                                                          | Description |
>   | :---------------------------------------------------------------------------- | :---------------------------------------------------------------------------- | :---------- |
>   | depositCids                                                                   | \[ContractId [AssetDeposit](#type-da-finance-fact-asset-assetdeposit-59560)\] | The asset deposits that will be consumed. All fields except for the quantity need to match. |
> 
> * **Choice AssetFungible\_Split**
>   
>   Splits an asset deposit according to the provided list of quantities.
>   
>   | Field                                                                                      | Type                                                                                       | Description |
>   | :----------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------- | :---------- |
>   | depositCid                                                                                 | ContractId [AssetDeposit](#type-da-finance-fact-asset-assetdeposit-59560)                  | The asset deposit that will be consumed. |
>   | quantities                                                                                 | \[[Decimal](https://docs.daml.com/daml/reference/base.html#type-ghc-types-decimal-54602)\] | The quantities of the newly created asset deposits. The total quantity needs to match the quantity of the provided asset. |

<a name="type-da-finance-rule-asset-assetlifecycle-46640"></a>**template** [AssetLifecycle](#type-da-finance-rule-asset-assetlifecycle-46640)

> Rule that allows to lifecycle asset deposits in the specified account according to
> the provided asset decomposition data.
> 
> | Field                                           | Type                                            | Description |
> | :---------------------------------------------- | :---------------------------------------------- | :---------- |
> | account                                         | [Account](#type-da-finance-types-account-82184) | The account for which the rule can be used. |
> | observers                                       | Set Party                                       |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice AssetLifecycle\_Process**
>   
>   Allows the owner to lifecycle an asset deposit according to an asset
>   decomposition published by the deposit.asset.id.signatories.
>   
>   | Field                                                                                 | Type                                                                                  | Description |
>   | :------------------------------------------------------------------------------------ | :------------------------------------------------------------------------------------ | :---------- |
>   | depositCid                                                                            | ContractId [AssetDeposit](#type-da-finance-fact-asset-assetdeposit-59560)             | Asset deposit to be lifecycled. |
>   | decompositionCid                                                                      | ContractId [AssetDecomposition](#type-da-finance-fact-asset-assetdecomposition-49641) | Asset decomposition describing the lifecycle effects. |

<a name="type-da-finance-rule-asset-assetsettlement-11846"></a>**template** [AssetSettlement](#type-da-finance-rule-asset-assetsettlement-11846)

> Rule that allows to credit, debit or transfer asset deposits in the specified account.
> 
> | Field                                           | Type                                            | Description |
> | :---------------------------------------------- | :---------------------------------------------- | :---------- |
> | account                                         | [Account](#type-da-finance-types-account-82184) | The account for which the rule can be used. |
> | observers                                       | Set Party                                       |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice AssetSettlement\_Credit**
>   
>   Gives the owner the right to archive an asset deposit.
>   
>   | Field                                                                     | Type                                                                      | Description |
>   | :------------------------------------------------------------------------ | :------------------------------------------------------------------------ | :---------- |
>   | depositCid                                                                | ContractId [AssetDeposit](#type-da-finance-fact-asset-assetdeposit-59560) | The asset deposit that will be consumed. |
> 
> * **Choice AssetSettlement\_Debit**
>   
>   Gives the provider the right to create an asset deposit signed by the
>   account.id.signatories.
>   
>   | Field                                       | Type                                        | Description |
>   | :------------------------------------------ | :------------------------------------------ | :---------- |
>   | asset                                       | [Asset](#type-da-finance-types-asset-31119) | The asset id and amount to be created. |
> 
> * **Choice AssetSettlement\_Debit\_Signatories**
>   
>   Helper functions for the account.id.signatories to create an asset deposit
>   signed by them.
>   
>   | Field                                       | Type                                        | Description |
>   | :------------------------------------------ | :------------------------------------------ | :---------- |
>   | asset                                       | [Asset](#type-da-finance-types-asset-31119) | The asset id and amount to be created. |
> 
> * **Choice AssetSettlement\_SetObservers**
>   
>   | Field        | Type         | Description |
>   | :----------- | :----------- | :---------- |
>   | newObservers | Set Party    |  |
> 
> * **Choice AssetSettlement\_Transfer**
>   
>   Gives the owner the right to transfer an asset deposit to a new owner.
>   
>   | Field                                                                           | Type                                                                            | Description |
>   | :------------------------------------------------------------------------------ | :------------------------------------------------------------------------------ | :---------- |
>   | receiver                                                                        | Party                                                                           | The party to which the asset deposit will be transferred to. |
>   | depositCid                                                                      | ContractId [AssetDeposit](#type-da-finance-fact-asset-assetdeposit-59560)       | The asset deposit that will be consumed. |
>   | debitSettlementCid                                                              | ContractId [AssetSettlement](#type-da-finance-rule-asset-assetsettlement-11846) | The settlement rule that allows to debit the new asset deposit in the receiver's account. |

<a name="type-da-finance-rule-asset-assetsettlementchain-2718"></a>**template** [AssetSettlementChain](#type-da-finance-rule-asset-assetsettlementchain-2718)

> Helper contract that allows to allocate assets to and settle a chain
> of transfer instructions.
> 
> | Field                                                                            | Type                                                                             | Description |
> | :------------------------------------------------------------------------------- | :------------------------------------------------------------------------------- | :---------- |
> | masterAgreement                                                                  | [MasterAgreement](#type-da-finance-types-masteragreement-56639)                  | The master agreement to which the settlement chain applies. |
> | tradeId                                                                          | [Id](#type-da-finance-types-id-77101)                                            | The trade under the master agreement to which the settlement chain applies. |
> | asset                                                                            | [Asset](#type-da-finance-types-asset-31119)                                      | The id and amount of the asset to be settled. |
> | steps                                                                            | \[[AssetSettlementStep](#type-da-finance-rule-asset-assetsettlementstep-69356)\] | The steps in the settlement chain. |
> | observers                                                                        | Set Party                                                                        |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice AssetSettlementChain\_AllocateNext**
>   
>   Allocates an asset deposit to the next step of the settlement chain.
>   
>   | Field                                                                     | Type                                                                      | Description |
>   | :------------------------------------------------------------------------ | :------------------------------------------------------------------------ | :---------- |
>   | depositCid                                                                | ContractId [AssetDeposit](#type-da-finance-fact-asset-assetdeposit-59560) | Specifies the asset deposit contract to be allocated. |
> 
> * **Choice AssetSettlementChain\_Process**
>   
>   Processes a settlement chain by transferring all allocated asset deposits.
>   
>   (no fields)
> 
> * **Choice AssetTransferAllocation\_Archive**
>   
>   (no fields)

## Data Types

<a name="type-da-finance-rule-asset-assetsettlementstep-69356"></a>**data** [AssetSettlementStep](#type-da-finance-rule-asset-assetsettlementstep-69356)

> Data describing a single step in a settlement chain.
> 
> <a name="constr-da-finance-rule-asset-assetsettlementstep-49371"></a>[AssetSettlementStep](#constr-da-finance-rule-asset-assetsettlementstep-49371)
> 
> > | Field                                                                                | Type                                                                                 | Description |
> > | :----------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------- | :---------- |
> > | sender                                                                               | Party                                                                                | The sender of an asset deposit. |
> > | receiver                                                                             | Party                                                                                | The receiver of an asset deposit. |
> > | depositCid                                                                           | Optional (ContractId [AssetDeposit](#type-da-finance-fact-asset-assetdeposit-59560)) | The allocated asset deposit. |
> > | creditSettlementCid                                                                  | ContractId [AssetSettlement](#type-da-finance-rule-asset-assetsettlement-11846)      | The settlement rule that allows the asset deposit to be credited to the sender. |
> > | debitSettlementCid                                                                   | ContractId [AssetSettlement](#type-da-finance-rule-asset-assetsettlement-11846)      | The settlement rule that allows the asset deposit to be debited to the receiver. |

# <a name="module-da-finance-rule-instrument-entitlement-21099"></a>Module DA.Finance.Rule.Instrument.Entitlement

## Templates

<a name="type-da-finance-rule-instrument-entitlement-entitlementlifecycle-46336"></a>**template** [EntitlementLifecycle](#type-da-finance-rule-instrument-entitlement-entitlementlifecycle-46336)

> Rule that helps with processing entitlements.
> 
> | Field       | Type        | Description |
> | :---------- | :---------- | :---------- |
> | signatories | Set Party   | Publishers of the entitlement reference data. |
> | observers   | Set Party   |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice EntitlementLifecycle\_Process**
>   
>   Allows the entitlement.id.signatories to create an asset decomposition
>   contract from the entitlement reference data.
>   
>   | Field                                                                                    | Type                                                                                     | Description |
>   | :--------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------- | :---------- |
>   | entitlementCid                                                                           | ContractId [Entitlement](#type-da-finance-fact-instrument-entitlement-entitlement-97017) | The provided entitlement reference data. |

# <a name="module-da-finance-rule-instrument-equity-31460"></a>Module DA.Finance.Rule.Instrument.Equity

## Templates

<a name="type-da-finance-rule-instrument-equity-equitycashdividendlifecycle-59970"></a>**template** [EquityCashDividendLifecycle](#type-da-finance-rule-instrument-equity-equitycashdividendlifecycle-59970)

> Rule that helps with processing equity cash dividends.
> 
> | Field       | Type        | Description |
> | :---------- | :---------- | :---------- |
> | signatories | Set Party   | Publishers of the dividend reference data. |
> | observers   | Set Party   |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice EquityCashDividendLifecycle\_Process**
>   
>   Allows the dividend.id.signatories to create an entitlement instrument
>   and an asset decomposition contract from the dividend reference data.
>   
>   | Field                                                                                             | Type                                                                                              | Description |
>   | :------------------------------------------------------------------------------------------------ | :------------------------------------------------------------------------------------------------ | :---------- |
>   | dividendCid                                                                                       | ContractId [EquityCashDividend](#type-da-finance-fact-instrument-equity-equitycashdividend-88187) | The provided dividend reference data. |
>   | entitlementIdLabel                                                                                | [Text](https://docs.daml.com/daml/reference/base.html#type-ghc-types-text-57703)                  | A label for the entitlement instrument describing the dividend payment. |

<a name="type-da-finance-rule-instrument-equity-equitystocksplitlifecycle-40922"></a>**template** [EquityStockSplitLifecycle](#type-da-finance-rule-instrument-equity-equitystocksplitlifecycle-40922)

> Rule that helps with processing equity stock splits.
> 
> | Field       | Type        | Description |
> | :---------- | :---------- | :---------- |
> | signatories | Set Party   | Publishers of the stock split reference data. |
> | observers   | Set Party   |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice EquityStockSplitLifecycle\_Process**
>   
>   Allows the stockSplit.id.signatories to create an asset decomposition
>   contract from the stock split reference data.
>   
>   | Field                                                                                         | Type                                                                                          | Description |
>   | :-------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------- | :---------- |
>   | stockSplitCid                                                                                 | ContractId [EquityStockSplit](#type-da-finance-fact-instrument-equity-equitystocksplit-99575) | The provided stock split reference data. |

## Data Types

<a name="type-da-finance-rule-instrument-equity-equitycashdividendlifecycleprocessresult-56989"></a>**data** [EquityCashDividendLifecycle\_Process\_Result](#type-da-finance-rule-instrument-equity-equitycashdividendlifecycleprocessresult-56989)

> The outputs of the EquityCashDividendLifecycle_Process choice.
> 
> <a name="constr-da-finance-rule-instrument-equity-equitycashdividendlifecycleprocessresult-77304"></a>[EquityCashDividendLifecycle\_Process\_Result](#constr-da-finance-rule-instrument-equity-equitycashdividendlifecycleprocessresult-77304)
> 
> > | Field                                                                                    | Type                                                                                     | Description |
> > | :--------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------- | :---------- |
> > | entitlementCid                                                                           | ContractId [Entitlement](#type-da-finance-fact-instrument-entitlement-entitlement-97017) | Entitlement instrument describing the upcoming dividend payment. |
> > | decompositionCid                                                                         | ContractId [AssetDecomposition](#type-da-finance-fact-asset-assetdecomposition-49641)    | Asset decomposition describing the increase of the asset's version number and the creation of a separate dividend entitlement. |
> 
> **instance** Choice [EquityCashDividendLifecycle](#type-da-finance-rule-instrument-equity-equitycashdividendlifecycle-59970) EquityCashDividendLifecycle\_Process [EquityCashDividendLifecycle\_Process\_Result](#type-da-finance-rule-instrument-equity-equitycashdividendlifecycleprocessresult-56989)

# <a name="module-da-finance-rule-trade-dvp-29636"></a>Module DA.Finance.Rule.Trade.Dvp

## Templates

<a name="type-da-finance-rule-trade-dvp-dvplifecycle-52814"></a>**template** [DvpLifecycle](#type-da-finance-rule-trade-dvp-dvplifecycle-52814)

> Rule that allows to lifecycle a Dvp trade under the specified master agreement
> according to the provided asset decomposition.
> 
> | Field                                                           | Type                                                            | Description |
> | :-------------------------------------------------------------- | :-------------------------------------------------------------- | :---------- |
> | masterAgreement                                                 | [MasterAgreement](#type-da-finance-types-masteragreement-56639) | The master agreement for which the rule can be used. |
> | observers                                                       | Set Party                                                       |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice DvpLifecycle\_Process1**
>   
>   | Field                                                                                          | Type                                                                                           | Description |
>   | :--------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------- | :---------- |
>   | param                                                                                          | [DvpLifecycle\_Process\_Param](#type-da-finance-rule-trade-dvp-dvplifecycleprocessparam-35136) |  |
> 
> * **Choice DvpLifecycle\_Process2**
>   
>   | Field                                                                                          | Type                                                                                           | Description |
>   | :--------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------- | :---------- |
>   | param                                                                                          | [DvpLifecycle\_Process\_Param](#type-da-finance-rule-trade-dvp-dvplifecycleprocessparam-35136) |  |

<a name="type-da-finance-rule-trade-dvp-dvpsettlement-10264"></a>**template** [DvpSettlement](#type-da-finance-rule-trade-dvp-dvpsettlement-10264)

> Rule that allows to settle a Dvp under the specified master agreement by providing
> fully allocated settlement chains for each payment and delivery obligation.
> 
> | Field                                                           | Type                                                            | Description |
> | :-------------------------------------------------------------- | :-------------------------------------------------------------- | :---------- |
> | masterAgreement                                                 | [MasterAgreement](#type-da-finance-types-masteragreement-56639) | The master agreement for which the rule can be used. |
> | observers                                                       | Set Party                                                       |  |
> 
> * **Choice Archive**
>   
>   (no fields)
> 
> * **Choice DvpSettlement\_Process1**
>   
>   | Field                                                                                            | Type                                                                                             | Description |
>   | :----------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------- | :---------- |
>   | param                                                                                            | [DvpSettlement\_Process\_Param](#type-da-finance-rule-trade-dvp-dvpsettlementprocessparam-27306) |  |
> 
> * **Choice DvpSettlement\_Process2**
>   
>   | Field                                                                                            | Type                                                                                             | Description |
>   | :----------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------- | :---------- |
>   | param                                                                                            | [DvpSettlement\_Process\_Param](#type-da-finance-rule-trade-dvp-dvpsettlementprocessparam-27306) |  |

## Data Types

<a name="type-da-finance-rule-trade-dvp-dvplifecycleprocessparam-35136"></a>**data** [DvpLifecycle\_Process\_Param](#type-da-finance-rule-trade-dvp-dvplifecycleprocessparam-35136)

> The input parameters of the DvpLifecycle_Process choices.
> 
> <a name="constr-da-finance-rule-trade-dvp-dvplifecycleprocessparam-9965"></a>[DvpLifecycle\_Process\_Param](#constr-da-finance-rule-trade-dvp-dvplifecycleprocessparam-9965)
> 
> > | Field                                                                                 | Type                                                                                  | Description |
> > | :------------------------------------------------------------------------------------ | :------------------------------------------------------------------------------------ | :---------- |
> > | dvpCid                                                                                | ContractId [Dvp](#type-da-finance-fact-trade-dvp-dvp-78355)                           | Dvp trade to be lifecycled. |
> > | decompositionCid                                                                      | ContractId [AssetDecomposition](#type-da-finance-fact-asset-assetdecomposition-49641) | Asset decomposition describing the lifecycle effects. |

<a name="type-da-finance-rule-trade-dvp-dvpsettlementprocessparam-27306"></a>**data** [DvpSettlement\_Process\_Param](#type-da-finance-rule-trade-dvp-dvpsettlementprocessparam-27306)

> The input parameters of the DvpSettlement_Process choices.
> 
> <a name="constr-da-finance-rule-trade-dvp-dvpsettlementprocessparam-57669"></a>[DvpSettlement\_Process\_Param](#constr-da-finance-rule-trade-dvp-dvpsettlementprocessparam-57669)
> 
> > | Field                                                                                        | Type                                                                                         | Description |
> > | :------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------- | :---------- |
> > | dvpCid                                                                                       | ContractId [Dvp](#type-da-finance-fact-trade-dvp-dvp-78355)                                  | Dvp trade to be settled |
> > | paymentChainCids                                                                             | \[ContractId [AssetSettlementChain](#type-da-finance-rule-asset-assetsettlementchain-2718)\] | Fully allocated settlement chain for each payment asset |
> > | deliveryChainCids                                                                            | \[ContractId [AssetSettlementChain](#type-da-finance-rule-asset-assetsettlementchain-2718)\] | Fully allocated settlement chain for each delivery asset |

<a name="type-da-finance-rule-trade-dvp-dvpsettlementprocessresult-61859"></a>**data** [DvpSettlement\_Process\_Result](#type-da-finance-rule-trade-dvp-dvpsettlementprocessresult-61859)

> The outputs of the DvpSettlement_Process choices.
> 
> <a name="constr-da-finance-rule-trade-dvp-dvpsettlementprocessresult-4894"></a>[DvpSettlement\_Process\_Result](#constr-da-finance-rule-trade-dvp-dvpsettlementprocessresult-4894)
> 
> > | Field                                                                             | Type                                                                              | Description |
> > | :-------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------- | :---------- |
> > | dvpCid                                                                            | ContractId [Dvp](#type-da-finance-fact-trade-dvp-dvp-78355)                       | Settled Dvp trade |
> > | paymentDepositCids                                                                | \[\[ContractId [AssetDeposit](#type-da-finance-fact-asset-assetdeposit-59560)\]\] | Transferred asset deposits for each payment obligation |
> > | deliveryDepositCids                                                               | \[\[ContractId [AssetDeposit](#type-da-finance-fact-asset-assetdeposit-59560)\]\] | Transferred asset deposits for each delivery obligation |
> 
> **instance** Choice [DvpSettlement](#type-da-finance-rule-trade-dvp-dvpsettlement-10264) DvpSettlement\_Process1 [DvpSettlement\_Process\_Result](#type-da-finance-rule-trade-dvp-dvpsettlementprocessresult-61859)
> 
> **instance** Choice [DvpSettlement](#type-da-finance-rule-trade-dvp-dvpsettlement-10264) DvpSettlement\_Process2 [DvpSettlement\_Process\_Result](#type-da-finance-rule-trade-dvp-dvpsettlementprocessresult-61859)

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
> 
> **instance** Choice [AssetSettlement](#type-da-finance-rule-asset-assetsettlement-11846) AssetSettlement\_Credit [Asset](#type-da-finance-types-asset-31119)

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

<a name="type-da-finance-types-settlementstatus-8447"></a>**data** [SettlementStatus](#type-da-finance-types-settlementstatus-8447)

> An enum that captures the settlement status of a trade.
> 
> <a name="constr-da-finance-types-settlementstatuspending-65532"></a>[SettlementStatus\_Pending](#constr-da-finance-types-settlementstatuspending-65532)
> 
> > An active trade prior to settlement
> 
> <a name="constr-da-finance-types-settlementstatusinstructed-93747"></a>[SettlementStatus\_Instructed](#constr-da-finance-types-settlementstatusinstructed-93747)
> 
> > A trade that has been instructed for settlement
> 
> <a name="constr-da-finance-types-settlementstatussettled-70006"></a>[SettlementStatus\_Settled](#constr-da-finance-types-settlementstatussettled-70006)
> 
> > A trade that has been settled

# <a name="module-da-finance-utils-23232"></a>Module DA.Finance.Utils

## Data Types

<a name="type-da-finance-utils-lens-35308"></a>**type** [Lens](#type-da-finance-utils-lens-35308) s a

> = (s -\> a, a -\> s -\> s)
> 
> Hand-crafted lens functionality to view, update and modify nested record fields.

## Functions

<a name="function-da-finance-utils-amp-95761"></a>[(\&)](#function-da-finance-utils-amp-95761)

> : a -\> (a -\> b) -\> b
> 
> `&` is a reverse application operator. This provides notational convenience.
> Its precedence is one higher than that of the forward application operator `$`,
> which allows `&` to be nested in `$`.

<a name="function-da-finance-utils-fetchandarchive-62570"></a>[fetchAndArchive](#function-da-finance-utils-fetchandarchive-62570)

> : Template a =\> ContractId a -\> Update a
> 
> Fetches a contract, archives it and returns its value.

<a name="function-da-finance-utils-assertonorafterdatemsg-90185"></a>[assertOnOrAfterDateMsg](#function-da-finance-utils-assertonorafterdatemsg-90185)

> : (CanAbort m, HasTime m) =\> [Text](https://docs.daml.com/daml/reference/base.html#type-ghc-types-text-57703) -\> Date -\> m ()
> 
> Checks that the ledger time is on or after the provided date.

<a name="function-da-finance-utils-maponce-98772"></a>[mapOnce](#function-da-finance-utils-maponce-98772)

> : (a -\> Optional a) -\> \[a\] -\> \[a\]
> 
> Replaces the first element of a list for which the provided function returns Some x.

<a name="function-da-finance-utils-zipchecked-49406"></a>[zipChecked](#function-da-finance-utils-zipchecked-49406)

> : \[a\] -\> \[b\] -\> \[(a, b)\]
> 
> Like zip but fails if the list lengths don't match

<a name="function-da-finance-utils-keys-35768"></a>[keys](#function-da-finance-utils-keys-35768)

> : MapKey k =\> Map k v -\> \[k\]
> 
> Return all keys of the map in ascending order.

<a name="function-da-finance-utils-elems-46879"></a>[elems](#function-da-finance-utils-elems-46879)

> : MapKey k =\> Map k v -\> \[v\]
> 
> Return all elements of the map in the ascending order of their keys.

<a name="function-da-finance-utils-bang-94718"></a>[(!)](#function-da-finance-utils-bang-94718)

> : MapKey k =\> Map k v -\> k -\> v
> 
> Find the value at a key. Calls error when the element can not be found.

<a name="function-da-finance-utils-inserta-51129"></a>[insertA](#function-da-finance-utils-inserta-51129)

> : (Action m, MapKey k) =\> Map k v -\> k -\> m v -\> m (Map k v)
> 
> Like map insert but takes an Action as value and returns the modified map as action.

<a name="function-da-finance-utils-gtgt-99975"></a>[(\~\>\>)](#function-da-finance-utils-gtgt-99975)

> : [Lens](#type-da-finance-utils-lens-35308) a b -\> [Lens](#type-da-finance-utils-lens-35308) b c -\> [Lens](#type-da-finance-utils-lens-35308) a c
> 
> Lens composition.
