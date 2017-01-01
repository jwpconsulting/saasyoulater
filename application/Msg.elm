module Msg exposing (..)

import Model exposing (ScenarioID)


type ScenarioMsg
    = SetMonths
    | SetChurnRate
    | SetCustomerGrowth
    | SetRevenue
    | SetCAC
    | SetMargin
    | SetCustomerStart
    | SetFixedCost
    | SetName
    | SetComment


type Msg
    = SetScenario ScenarioID ScenarioMsg String
    | ChooseScenario ScenarioID
    | NewScenario
    | SetCurrency String
    | LocalStorageReceive ( String, Maybe String )
    | DeleteScenario ScenarioID
