module Update exposing (update)

import Model exposing (Model, maxMonths, newScenario, currentScenario)
import Msg exposing (..)
import Dict
import Decode exposing (..)
import Encode exposing (..)
import LocalStorage


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
                            Model.updateGrowth scenario <| decodePercentage value

                        SetRevenue ->
                            { scenario
                                | revenue = decodeInt value
                            }

                        SetCAC ->
                            { scenario
                                | cac = decodeInt value
                            }

                        SetMargin ->
                            { scenario
                                | revenueGrossMargin = decodePercentage value
                            }

                        SetCustomerStart ->
                            Model.setStartValue scenario <| decodeInt value

                        SetFixedCost ->
                            { scenario
                                | fixedCost = decodeInt value
                            }
            in
                { model
                    | scenarios = Dict.insert scenarioID scenario_ model.scenarios
                }
                    ! []

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

        SetCurrency value ->
            { model | currency = decodeCurrency value }
                ! [ LocalStorage.set
                        ( Model.currencyKey
                        , encodeCurrency <| decodeCurrency value
                        )
                  ]

        LocalStorageReceive ( key, value ) ->
            case key of
                "currency" ->
                    case value of
                        Just value ->
                            { model
                                | currency = decodeCurrency value
                            }
                                ! []

                        Nothing ->
                            model
                                ! [ LocalStorage.set
                                        ( Model.currencyKey
                                        , encodeCurrency model.currency
                                        )
                                  ]

                _ ->
                    model ! []
