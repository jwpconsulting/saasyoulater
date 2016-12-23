module Subscriptions exposing (..)

import Model exposing (Model)
import Msg exposing (Msg(..))
import LocalStorage exposing (receive)


subscriptions : Model.Model -> Sub Msg.Msg
subscriptions model =
    receive LocalStorageReceive
