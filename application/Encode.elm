module Encode exposing (..)

import Model exposing (..)
import Json.Encode exposing (..)
import Dict


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


encodeCurrencyJson : Currency -> Value
encodeCurrencyJson =
    encodeCurrency >> string


encodeScenarios : Scenarios -> Value
encodeScenarios scenarios =
    object <| List.map (\( k, v ) -> ( toString k, encodeScenario v )) <| Dict.toList scenarios


encodeScenario : Scenario -> Value
encodeScenario scenario =
    object
        [ ( "months", int scenario.months )
        , ( "revenue", int scenario.revenue )
        , ( "customerGrowth", encodeCustomerGrowth scenario.customerGrowth )
        , ( "revenueGrossMargin", float scenario.revenueGrossMargin )
        , ( "cac", int scenario.cac )
        , ( "fixedCost", int scenario.fixedCost )
        ]


encodeCustomerGrowth : CustomerGrowth -> Value
encodeCustomerGrowth customerGrowth =
    object
        [ ( "start", int customerGrowth.startValue )
        , ( "growth", float customerGrowth.growthRate )
        , ( "churn", float customerGrowth.churnRate )
        ]
