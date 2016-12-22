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


currencyName : Currency -> String
currencyName currency =
    case currency of
        EUR ->
            "EUR"

        USD ->
            "USD"

        AUD ->
            "AUD"

        JPY ->
            "JPY"
