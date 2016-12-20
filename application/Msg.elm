module Msg exposing (..)

import Model exposing (ScenarioID)


type ScenarioMsg
    = SetMonths
    | SetChurnRate
    | SetCustomerGrowth
    | SetRevenue
    | SetCAC
    | SetOpCost
    | SetMargin


type Msg
    = SetScenario ScenarioMsg ScenarioID String
    | ChooseScenario ScenarioID
    | NewScenario
