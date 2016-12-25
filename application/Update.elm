module Update exposing (update)

import Model exposing (Model, maxMonths, newScenario, currentScenario)
import Msg exposing (..)
import Dict
import Decode exposing (..)
import Encode exposing (..)
import LocalStorage
import Json.Decode
import Json.Encode


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetScenario msg scenarioID value ->
            case currentScenario model of
                Nothing ->
                    model ! []

                Just scenario ->
                    let
                        model_ =
                            { model
                                | scenarios =
                                    Dict.insert scenarioID
                                        (case msg of
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
                                        )
                                        model.scenarios
                            }
                    in
                        model_
                            ! [ LocalStorage.set
                                    ( "scenarios"
                                    , Json.Encode.encode 0 <|
                                        encodeScenarios model_.scenarios
                                    )
                              ]

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

                model_ =
                    { model | scenarios = scenarios_ }
            in
                model_
                    ! [ LocalStorage.set
                            ( "scenarios"
                            , Json.Encode.encode 0 <|
                                encodeScenarios model_.scenarios
                            )
                      ]

        SetCurrency value ->
            { model | currency = decodeCurrency value }
                ! [ LocalStorage.set
                        ( Model.currencyKey
                        , Json.Encode.encode 0 <| encodeCurrencyJson <| decodeCurrency value
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
                                        , Json.Encode.encode 0 <| encodeCurrencyJson model.currency
                                        )
                                  ]

                "scenarios" ->
                    case Debug.log "scenarios" value of
                        Nothing ->
                            let
                                model_ =
                                    { model | scenarios = Model.newScenarios }
                            in
                                model_
                                    ! [ LocalStorage.set
                                            ( "scenarios"
                                            , Json.Encode.encode 0 <| encodeScenarios model_.scenarios
                                            )
                                      ]

                        Just scenarios ->
                            case Debug.log "decode" <| decodeScenarios <| Json.Decode.decodeString Decode.scenarios scenarios of
                                Ok scenarios ->
                                    { model | scenarios = scenarios } ! []

                                Err _ ->
                                    { model | scenarios = Model.newScenarios }
                                        ! [ LocalStorage.set
                                                ( "scenarios"
                                                , Json.Encode.encode 0 <| encodeScenarios Model.newScenarios
                                                )
                                          ]

                key ->
                    case Debug.log "unknown key" key of
                        _ ->
                            model ! []
