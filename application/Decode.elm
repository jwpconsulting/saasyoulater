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

        _ ->
            Nothing
