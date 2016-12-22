module Decode exposing (..)

import Model exposing (Currency(..))


decodeInt : String -> Int
decodeInt string =
    case String.toInt string of
        Ok value ->
            value

        Err _ ->
            0


decodeIntWithMaximum : String -> Int -> Int
decodeIntWithMaximum string value =
    min (decodeInt string) value


decodePercentage : String -> Float
decodePercentage string =
    case String.toFloat string of
        Ok value ->
            value / 100

        _ ->
            0


decodeCurrency : String -> Currency
decodeCurrency string =
    case string of
        "aud" ->
            AUD

        "eur" ->
            EUR

        "jpy" ->
            JPY

        "usd" ->
            USD

        _ ->
            USD
