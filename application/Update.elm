module Update exposing (update)

import Model exposing (Model, maxMonths, newScenario, currentScenario)
import String
import Msg exposing (..)
import Dict


decodeInt : String -> Int
decodeInt string =
    case String.toInt string of
        Ok value ->
            value

        Err _ ->
            0


decodeIntWithMaximum : String -> Int -> Int
decodeIntWithMaximum string value =
    min (decodeInt string) value


decodePercentage : String -> Float
decodePercentage string =
    case String.toFloat string of
        Ok value ->
            value / 100

        _ ->
            0


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetScenario msg scenarioID value ->
            let
                scenario =
                    currentScenario model

                scenario_ =
                    case msg of
                        SetMonths ->
                            { scenario
                                | months = decodeIntWithMaximum value maxMonths
                            }

                        SetChurnRate ->
                            { scenario
                                | churnRate = decodePercentage value
                            }

                        SetCustomerGrowth ->
                            { scenario
                                | customerGrowth = decodeInt value
                            }

                        SetRevenue ->
                            { scenario
                                | revenue = decodeInt value
                            }

                        SetCAC ->
                            { scenario
                                | cac = decodeInt value
                            }

                        SetOpCost ->
                            { scenario
                                | opCost = decodeInt value
                            }

                        SetMargin ->
                            { scenario
                                | revenueGrossMargin = decodePercentage value
                            }

                scenarios_ =
                    Dict.insert scenarioID scenario_ model.scenarios
            in
                { model | scenarios = scenarios_ } ! []

        ChooseScenario id ->
            { model | currentScenario = id } ! []

        NewScenario ->
            let
                highest =
                    (Dict.keys model.scenarios
                        |> List.maximum
                        |> Maybe.withDefault 0
                    )
                        + 1

                scenarios_ =
                    Dict.insert highest Model.newScenario model.scenarios
            in
                { model | scenarios = scenarios_ } ! []
