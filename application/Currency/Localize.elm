module Currency.Localize exposing (..)

import Currency.Currency exposing (Currency(..))


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

        TRY ->
            "₺"


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

        TRY ->
            "TRY"
