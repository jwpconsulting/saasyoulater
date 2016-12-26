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


type alias GrowthRate =
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


type alias CustomerGrowth =
    { startValue : StartValue
    , growthRate : GrowthRate
    , churnRate : ChurnRate
    }


emptyRelative : CustomerGrowth
emptyRelative =
    { startValue = 10
    , growthRate = 0.4
    , churnRate = 0.03
    }


type alias Scenario =
    { months : Month
    , revenue : Money
    , customerGrowth : CustomerGrowth
    , revenueGrossMargin : Percentage
    , cac : Money
    , fixedCost : Money
    , name : Maybe String
    , comment : Maybe String
    }


newScenario : Scenario
newScenario =
    { months = 24
    , revenue = 30
    , customerGrowth = emptyRelative
    , revenueGrossMargin = 0.5
    , cac = 45
    , fixedCost = 100
    , name = Nothing
    , comment = Nothing
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


updateGrowth : Scenario -> GrowthRate -> Scenario
updateGrowth scenario growth =
    let
        customerGrowth =
            scenario.customerGrowth

        customerGrowth_ =
            { customerGrowth
                | growthRate = growth
            }
    in
        { scenario
            | customerGrowth = customerGrowth_
        }


setStartValue : Scenario -> StartValue -> Scenario
setStartValue scenario value =
    let
        customerGrowth =
            scenario.customerGrowth

        customerGrowth_ =
            { customerGrowth
                | startValue = value
            }
    in
        { scenario
            | customerGrowth = customerGrowth_
        }


setChurn : Scenario -> ChurnRate -> Scenario
setChurn scenario churnRate =
    let
        customerGrowth =
            scenario.customerGrowth

        customerGrowth_ =
            { customerGrowth
                | churnRate = churnRate
            }
    in
        { scenario
            | customerGrowth = customerGrowth_
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
