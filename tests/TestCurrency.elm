module TestCurrency exposing (currency)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String
import Model
import Math
import Currency.Currency exposing (..)
import Currency.Encode exposing (..)
import Currency.Decode exposing (..)
import Currency.Localize exposing (..)


testCurrency currency =
    (\() -> Expect.equal (Just currency) (decodeCurrency <| encodeCurrency currency))
        |> test ((encodeCurrency currency) ++ " encodes properly")


currency : Test
currency =
    describe "Currency" <|
        List.map testCurrency currencies
