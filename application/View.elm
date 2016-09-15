module View exposing (view)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model)
import Math
import Msg exposing (..)
import Humanize exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ h1 []
            [ text "Saas You Later"
            , small [] [ text " - SaaS Business Model Calculator" ]
            ]
        , div [ class "row" ]
            [ div [ class "col-xs-6 col-md-3" ]  (controls model)
            , div [ class "col-xs-6 col-md-3 col-md-push-6" ] (results model)
            , div [ class "col-xs-12 col-md-6 col-md-pull-3" ] (numbers model)
            ]
        ]


controls : Model -> List (Html Msg)
controls model =
    let
        controlLabel labelText =
            label [ class "control-label col-xs-6" ] [ text labelText ]

        numberInput numberValue message min max step =
            div [ class "col-xs-6" ]
                [ input
                    [ type' "number"
                    , class "form-control"
                    , numberValue |> toString |> value
                    , onInput message
                    , min |> toString |> Html.Attributes.min
                    , max |> toString |> Html.Attributes.max
                    , step |> toString |> Html.Attributes.step
                    ]
                    []
                ]
    in
        [ Html.form [ class "form-horizontal" ]
            [ h2 [] [ text "Parameters" ]
            , div [ class "form-group" ]
                [ controlLabel "Months"
                , numberInput model.months SetMonths 1 100 1
                ]
            , div [ class "form-group" ]
                [ controlLabel "Churn Rate (%)"
                , numberInput (model.churnRate * 100 |> round) SetChurnRate 1 100 1
                ]
            , div [ class "form-group" ]
                [ controlLabel "Customer Growth per Month"
                , numberInput model.customerGrowth SetCustomerGrowth 0 1000 10
                ]
            , div [ class "form-group" ]
                [ controlLabel "Revenue per Customer per Month"
                , numberInput model.revenue SetRevenue 0 1000 10
                ]
            , div [ class "form-group" ]
                [ controlLabel "Customer Acquisition Cost"
                , numberInput model.cac SetCAC 0 5000 5
                ]
            , div [ class "form-group" ]
                [ controlLabel "Fixed Operation costs"
                , numberInput model.opCost SetOpCost 0 1000 100
                ]
            , div [ class "form-group" ]
                [ controlLabel "Gross Margin"
                , numberInput (model.revenueGrossMargin * 100 |> round) SetMargin 0 100 5
                ]
            ]
        , h4 [] [ text "Explanation" ]
        , dl []
            [ dt [] [ text "Months" ]
            , dd [] [ text "Length of business forecast" ]
            , dt [] [ text "Churn Rate" ]
            , dd [] [ text "Percentage of customers leaving monthly" ]
            , dt [] [ text "Customer Growth per Month" ]
            , dd [] [ text "Number of customers signing up in one month" ]
            , dt [] [ text "Revenue per customer per Month" ]
            , dd [] [ text "Revenue for one customer through subscription fees or similar" ]
            , dt [] [ text "Customer Acquisition Cost" ]
            , dd [] [ text "Cost related to acquiring one customer" ]
            , dt [] [ text "Fixed Operation Cost" ]
            , dd [] [ text "Fixed costs such as salaries, rent" ]
            ]
        ]


numbers : Model -> List (Html Msg)
numbers model =
    let
        months =
            [1..model.months]

        breakEven =
            Math.breakEven model

        row month =
            let
                trClass =
                    class
                        (case breakEven of
                            Just breakEvenMonth ->
                                if month >= breakEvenMonth then
                                    "success"
                                else
                                    "warning"

                            Nothing ->
                                "danger"
                        )
            in
                tr [ trClass ]
                    [ td [] [ toString month |> text ]
                    , [ Math.customerCohorts model month
                            |> round
                            |> toString
                            |> text
                      ]
                        |> td []
                    , Math.revenueCohorts model month |> humanizeValue |> td []
                    , Math.grossMargin model month |> humanizeValue |> td []
                    , Math.expenses model |> toFloat |> humanizeValue |> td []
                    , Math.earnings model month |> humanizeValue |> td []
                    , Math.cumulativeEarnings model month |> humanizeValue |> td []
                    ]

        rows =
            List.map row (Math.months model.months)
    in
        [ h2 [] [ text "Numbers" ]
        , Html.table [ class "table table-hover table-condensed" ]
            [ thead []
                [ tr []
                    [ th [] [ text "Month" ]
                    , th [] [ text "Customers" ]
                    , th [] [ text "Revenue" ]
                    , th [] [ text "Gross Margin" ]
                    , th [] [ text "Expenses" ]
                    , th [] [ text "EBIT" ]
                    , th [] [ text "Cumulative EBIT" ]
                    ]
                ]
            , tbody [] rows
            ]
        ]


results : Model -> List (Html Msg)
results model =
    let
        breakEven =
            Math.breakEven model |> humanize

        earningsBreakEven =
            Math.earningsBreakEven model |> humanize

        averageLife =
            Math.averageLife model |> humanizeDuration

        cltv =
            Math.cltv model |> toFloat |> humanizeValue

        ltvcac =
            Math.ltvcac model |> humanizeRatio

        minimumCumulativeEarnings =
            Math.minimumCumulativeEarnings model |> humanizeValue
    in
        [ h2 [] [ text "Results" ]
        , dl []
            [ dt [] [ text "Earnings positive" ]
            , dd [] earningsBreakEven
            , dt [] [ text "Cumulative Earnings positive" ]
            , dd [] breakEven
            , dt [] [ text "Average Customer Life" ]
            , dd [] averageLife
            , dt [] [ text "Customer Lifetime Value" ]
            , dd [] cltv
            , dt [] [ text "LTV over CAC" ]
            , dd [] ltvcac
            , dt [] [ text "Minimum Cumulative Earnings" ]
            , dd [] minimumCumulativeEarnings
            ]
        , h4 [] [ text "Explanation" ]
        , dl []
            [ dt [] [ text "Earnings positive" ]
            , dd [] [ text "Month at which earnings cross 0 " ]
            , dt [] [ text "Cumulative Earnings positive" ]
            , dd [] [ text "Month at which cumulative earnings (e.g. bank account) cross 0" ]
            , dt [] [ text "Average Customer Lifetime" ]
            , dd [] [ text "Average number of months a customer stays with this business " ]
            , dt [] [ text "Customer Lifetime Value" ]
            , dd [] [ text "Average revenue earned through one customer over the whole lifetime " ]
            , dt [] [ text "LTV over CAC" ]
            , dd [] [ text "Ratio of Lifetime Value over Customer Acquisition Cost. Less than 1 means acquisition will not yield in profit." ]
            , dt [] [ text "Minimum Cumulative Earnings" ]
            , dd [] [ text "Lowest point in cumulative earnings. Bank account needs to be able to shoulder this." ]
            ]
        ]
