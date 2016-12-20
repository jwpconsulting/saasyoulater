module Main exposing (..)

import Model
import Html
import Update
import View
import Msg


main : Program Never Model.Model Msg.Msg
main =
    Html.program
        { init = ( Model.init, Cmd.none )
        , update = Update.update
        , view = View.view
        , subscriptions = \_ -> Sub.none
        }
