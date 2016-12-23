module Cmds exposing (..)

import Msg exposing (..)
import LocalStorage


retrieveCurrency : Cmd Msg
retrieveCurrency =
    LocalStorage.get "currency"
