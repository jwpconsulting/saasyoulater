module Msg exposing (..)

import Model exposing (ScenarioID, Currency)


type ScenarioMsg
    = SetMonths
    | SetChurnRate
    | SetCustomerGrowth
    | SetRevenue
    | SetCAC
    | SetMargin
    | SetCustomerStart
    | SetFixedCost


type Msg
    = SetScenario ScenarioMsg ScenarioID String
    | ChooseScenario ScenarioID
    | NewScenario
    | SetCurrency String
    | LocalStorageReceive ( String, Maybe String )
