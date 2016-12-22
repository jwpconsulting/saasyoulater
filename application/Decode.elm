module Decode exposing (..)

import Model exposing (Currency(..))
import Msg exposing (..)


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


decodeCurrency : Maybe String -> Msg
decodeCurrency string =
    case string of
        Just string ->
            case string of
                "aud" ->
                    SetCurrency (Just AUD)

                "eur" ->
                    SetCurrency (Just EUR)

                "jpy" ->
                    SetCurrency (Just JPY)

                "usd" ->
                    SetCurrency (Just USD)

                _ ->
                    SetCurrency Nothing
        Nothing ->
            SetCurrency Nothing
