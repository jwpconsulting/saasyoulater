module Model exposing (..)

import Dict exposing (Dict)


type alias ScenarioID =
    Int


defaultCurrency : Currency
defaultCurrency = USD


type alias Model =
    { scenarios : Dict.Dict ScenarioID Scenario
    , currentScenario : ScenarioID
    , currency : Currency
    }


type alias StartValue =
    Int


type alias GrowthValue =
    Float


type alias ChurnRate =
    Float


type alias Month =
    Int


type alias Money =
    Int


type alias Percentage =
    Float


type Currency
    = USD
    | EUR
    | AUD
    | JPY


currencies : List Currency
currencies =
    [ defaultCurrency
    , EUR
    , AUD
    , JPY
    ]


type CustomerGrowth
    = Relative StartValue GrowthValue


emptyRelative : CustomerGrowth
emptyRelative =
    Relative 10 0.2


type alias Scenario =
    { months : Month
    , churnRate : Percentage
    , revenue : Money
    , customerGrowth : CustomerGrowth
    , revenueGrossMargin : Percentage
    , cac : Money
    , fixedCost : Money
    }


newScenario : Scenario
newScenario =
    { months = 24
    , churnRate = 0.03
    , revenue = 30
    , customerGrowth = emptyRelative
    , revenueGrossMargin = 0.75
    , cac = 50
    , fixedCost = 100
    }


init : Model
init =
    { scenarios = Dict.fromList [ ( 1, newScenario ) ]
    , currentScenario = 1
    , currency = defaultCurrency
    }


maxMonths : Int
maxMonths =
    100


currentScenario : Model -> Scenario
currentScenario model =
    Dict.get model.currentScenario model.scenarios
        |> Maybe.withDefault newScenario


updateGrowth : Scenario -> GrowthValue -> Scenario
updateGrowth scenario value =
    let
        customerGrowth =
            case scenario.customerGrowth of
                Relative start growth ->
                    Relative start value
    in
        { scenario
            | customerGrowth = customerGrowth
        }


setStartValue : Scenario -> StartValue -> Scenario
setStartValue scenario value =
    let
        customerGrowth =
            case scenario.customerGrowth of
                Relative _ growth ->
                    Relative value growth
    in
        { scenario
            | customerGrowth = customerGrowth
        }
