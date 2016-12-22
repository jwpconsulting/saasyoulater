module Localize exposing (..)

import Model exposing (Currency(..))


localizeCurrency : Currency -> String
localizeCurrency currency =
    case currency of
        EUR ->
            "€"

        USD ->
            "$"

        AUD ->
            "$"

        JPY ->
            "¥"
