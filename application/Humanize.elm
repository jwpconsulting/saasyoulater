module Humanize exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (..)


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


humanizeValue : Float -> List (Html Msg)
humanizeValue value =
    [ strong
        [ class
            (if value < 1 then
                "text-warning"
             else
                "text-success"
            )
        ]
        [ value |> round |> toString |> text ]
    , " €" |> text
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
