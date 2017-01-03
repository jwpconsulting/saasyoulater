module Currency.Decode exposing (decodeCurrency)

import Currency.Currency exposing (Currency(..))


decodeCurrency : String -> Maybe Currency
decodeCurrency string =
    case string of
        "aud" ->
            Just AUD

        "eur" ->
            Just EUR

        "jpy" ->
            Just JPY

        "usd" ->
            Just USD

        "try" ->
            Just TRY

        "uah" ->
            Just UAH

        "inr" ->
            Just INR

        "vnd" ->
            Just VND

        _ ->
            Nothing
