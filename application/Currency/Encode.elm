module Currency.Encode
    exposing
        ( encodeCurrency
        , encodeCurrencyJson
        )

import Currency.Currency exposing (Currency(..))
import Json.Encode exposing (string, Value)


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

        TRY ->
            "try"

        UAH ->
            "uah"

        INR ->
            "inr"

        VND ->
            "vnd"


encodeCurrencyJson : Currency -> Value
encodeCurrencyJson =
    encodeCurrency >> string
