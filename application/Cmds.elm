module Cmds exposing (..)

import Msg exposing (..)
import LocalStorage


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
