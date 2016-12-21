module Model
    exposing
        (..)

import Dict exposing (Dict)
import Decode exposing (..)


type alias ScenarioID =
    Int


type alias Model =
    { scenarios : Dict.Dict ScenarioID Scenario
    , currentScenario : ScenarioID
    }

type alias StartValue = Int
type CustomerGrowth = Relative StartValue Float | Absolute StartValue Int

emptyRelative : CustomerGrowth
emptyRelative = Relative 10 0.1

emptyAbsolute : CustomerGrowth
emptyAbsolute = Absolute 0 10

type alias Scenario =
    { months : Int
    , churnRate : Float
    , revenue : Int
    , customerGrowth : CustomerGrowth
    , revenueGrossMargin : Float
    , cac : Int
    }


newScenario : Scenario
newScenario =
    { months = 24
    , churnRate = 0.03
    , revenue = 30
    , customerGrowth = emptyRelative
    , revenueGrossMargin = 0.75
    , cac = 50
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


updateGrowth : Scenario -> String -> Scenario
updateGrowth scenario value =
    let
        customerGrowth =
            case scenario.customerGrowth of
                Absolute start growth ->
                    Absolute start <| decodeInt value
                Relative start growth ->
                    Relative start <| decodePercentage value
    in
        { scenario
        | customerGrowth = customerGrowth
        }

setStartValue : Scenario -> String -> Scenario
setStartValue scenario value =
    let
        value_ = decodeInt value
        customerGrowth =
            case scenario.customerGrowth of
                Absolute _ growth ->
                    Absolute value_ growth
                Relative _ growth ->
                    Relative value_ growth
    in
        { scenario
        | customerGrowth = customerGrowth
        }
