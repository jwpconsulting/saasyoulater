module Humanize exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (..)
import Currency.Currency exposing (Currency(..))
import Currency.Localize exposing (..)


humanize : Maybe number -> List (Html Msg)
humanize month =
    case month of
        Just month ->
            [ text "At month "
            , strong [] [ toString month |> text ]
            ]

        Nothing ->
            [ text "Never" ]


humanizeDuration : number -> List (Html Msg)
humanizeDuration month =
    let
        suffix =
            case month of
                1 ->
                    " month"

                _ ->
                    " months"
    in
        [ strong [] [ toString month |> text ]
        , suffix |> text
        ]


humanizeValue : Currency -> Int -> List (Html Msg)
humanizeValue currency value =
    [ strong
        [ class
            (if value < 1 then
                "text-warning"
             else
                "text-success"
            )
        ]
        [ value |> toString |> text ]
    , text <| " " ++ localizeCurrency currency
    ]


humanizeRatio : Float -> List (Html Msg)
humanizeRatio value =
    [ span
        [ class
            (if value < 1 then
                "text-warning"
             else
                "text-success"
            )
        ]
        [ value |> toString |> text
        ]
    ]
