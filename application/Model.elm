module Model exposing (..)

import Dict exposing (Dict)


type alias ScenarioID =
    Int


type alias Scenarios =
    Dict.Dict ScenarioID Scenario


defaultCurrency : Currency
defaultCurrency =
    USD


type alias Model =
    { scenarios : Scenarios
    , currentScenario : Maybe ScenarioID
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


newScenarios : Scenarios
newScenarios =
    Dict.fromList [ ( 1, newScenario ) ]


init : Model
init =
    { scenarios = Dict.empty
    , currentScenario = Just 1
    , currency = defaultCurrency
    }


maxMonths : Int
maxMonths =
    100


currentScenario : Model -> Maybe ( ScenarioID, Scenario )
currentScenario model =
    case model.currentScenario of
        Nothing ->
            Nothing

        Just id ->
            case Dict.get id model.scenarios of
                Just scenario ->
                    Just ( id, scenario )

                _ ->
                    Nothing


updateGrowth : Scenario -> GrowthValue -> Scenario
updateGrowth scenario value =
    let
        customerGrowth =
            case scenario.customerGrowth of
                Relative start _ ->
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


currencyKey : String
currencyKey =
    "currency"


firstScenarioID : Scenarios -> Maybe ScenarioID
firstScenarioID scenarios =
    List.minimum <| Dict.keys scenarios


lowestFreeId : Scenarios -> ScenarioID
lowestFreeId scenarios =
    let
        findFree x =
            if Dict.member x scenarios then
                findFree <| x + 1
            else
                x
    in
        findFree 1
