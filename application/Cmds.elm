module Cmds exposing (..)

import Encode exposing (..)
import Json.Encode
import LocalStorage
import Model exposing (Model, Currency)
import Msg exposing (..)


startCmds : Cmd Msg
startCmds =
    Cmd.batch
        [ retrieveCurrency
        , retrieveScenarios
        ]


retrieveCurrency : Cmd Msg
retrieveCurrency =
    LocalStorage.get "currency"


retrieveScenarios : Cmd Msg
retrieveScenarios =
    LocalStorage.get "scenarios"


storeScenarios : Model -> Cmd Msg
storeScenarios model =
    LocalStorage.set
        ( "scenarios"
        , Json.Encode.encode 0 <|
            encodeScenarios model.scenarios
        )


storeCurrency : Currency -> Cmd Msg
storeCurrency currency =
    LocalStorage.set
        ( Model.currencyKey
        , Json.Encode.encode 0 <| encodeCurrencyJson currency
        )
