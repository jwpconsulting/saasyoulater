module Encode exposing (..)

import Model exposing (..)
import Json.Encode exposing (..)


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


encodeScenario : Scenario -> Value
encodeScenario scenario =
    object
        [ ( "months", int scenario.months )
        , ( "churnRate", float scenario.churnRate )
        , ( "revenue", int scenario.revenue )
        , ( "customerGrowth", encodeCustomerGrowth scenario.customerGrowth )
        , ( "revenueGrossMargin", float scenario.revenueGrossMargin )
        , ( "cac", int scenario.cac )
        , ( "fixedCost", int scenario.fixedCost )
        ]


encodeCustomerGrowth : CustomerGrowth -> Value
encodeCustomerGrowth customerGrowth =
    case customerGrowth of
        Relative start growth ->
            object
                [ ( "start", int start )
                , ( "growth", float growth )
                ]
