module Encode exposing (..)

import Model exposing (Currency(..))


encodeCurrency : Currency -> String
encodeCurrency currency =
    case currency of
        USD ->
            "usd"

        EUR ->
            "eur"

        AUD ->
            "aud"

        JPY ->
            "jpy"
