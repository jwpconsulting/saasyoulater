module Msg exposing (..)

import Model exposing (ScenarioID)


type ScenarioMsg
    = SetMonths
    | SetChurnRate
    | SetCustomerGrowth
    | SetRevenue
    | SetCAC
    | SetMargin
    | SetGrowthType
    | SetCustomerStart


type Msg
    = SetScenario ScenarioMsg ScenarioID String
    | ChooseScenario ScenarioID
    | NewScenario
