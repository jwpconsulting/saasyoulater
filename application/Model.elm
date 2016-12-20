module Model
    exposing
        ( Model
        , Scenario
        , ScenarioID
        , currentScenario
        , init
        , maxMonths
        , newScenario
        )

import Dict exposing (Dict)


type alias ScenarioID =
    Int


type alias Model =
    { scenarios : Dict.Dict ScenarioID Scenario
    , currentScenario : ScenarioID
    }


type alias Scenario =
    { months : Int
    , churnRate : Float
    , revenue : Int
    , customerGrowth : Int
    , revenueGrossMargin : Float
    , cac : Int
    , opCost : Int
    }


newScenario : Scenario
newScenario =
    { months = 24
    , churnRate = 0.03
    , revenue = 30
    , customerGrowth = 10
    , revenueGrossMargin = 0.75
    , cac = 50
    , opCost = 200
    }


init : Model
init =
    { scenarios = Dict.fromList [ ( 1, newScenario ) ]
    , currentScenario = 1
    }


maxMonths : Int
maxMonths =
    100


currentScenario : Model -> Scenario
currentScenario model =
    Dict.get model.currentScenario model.scenarios
        |> Maybe.withDefault newScenario
