module Main exposing (..)

import Model
import Html.App
import Update
import View


main : Program Never
main =
    Html.App.program
        { init = ( Model.init, Cmd.none )
        , update = Update.update
        , view = View.view
        , subscriptions = \_ -> Sub.none
        }
