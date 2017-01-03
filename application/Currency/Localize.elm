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

        UAH ->
            "₴"


currencyName : Currency -> String
currencyName currency =
    case currency of
        EUR ->
            "Euro"

        USD ->
            "United States dollar"

        AUD ->
            "Australian dollar"

        JPY ->
            "Japanese yen"

        TRY ->
            "Turkish lira"

        UAH ->
            "Ukrainian hryvnia"
