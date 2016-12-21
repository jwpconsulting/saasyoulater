module View exposing (view)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model, Scenario, ScenarioID)
import Dict
import Math
import Events exposing (onSelect)
import Msg exposing (..)
import Humanize exposing (..)


view : Model -> Html Msg
view model =
    let
        scenario =
            Model.currentScenario model
    in
        div [] <|
            [ h1 []
                [ text "SaaS You Later"
                , small [] [ text " - SaaS Business Model Calculator" ]
                ]
            , ul [ class "nav nav-tabs" ] <|
                (List.map (scenarioTab model.currentScenario) <|
                    Dict.keys model.scenarios
                )
                    ++ [ newTab ]
            , div [ class "row" ]
                [ div [ class "col-xs-6 col-md-3" ]
                    (controls model.currentScenario scenario)
                , div [ class "col-xs-6 col-md-2 col-md-push-7" ]
                    (results scenario)
                , div [ class "col-xs-12 col-md-7 col-md-pull-2" ]
                    (numbers scenario)
                ]
            , hr [] []
            ]
                ++ help
                ++ [ hr [] []
                   , footer
                   ]


newTab : Html Msg
newTab =
    li []
        [ a
            [ href "#"
            , onClick NewScenario
            ]
            [ text "+ Add a Scenario" ]
        ]


scenarioTab : ScenarioID -> ScenarioID -> Html Msg
scenarioTab currentScenario id =
    li
        [ class <|
            if currentScenario == id then
                "active"
            else
                ""
        ]
        [ a
            [ href "#"
            , onClick (ChooseScenario id)
            ]
            [ text "Scenario "
            , text <| toString id
            ]
        ]


controlLabel : String -> Html Msg
controlLabel labelText =
    label [ class "control-label col-xs-6" ] [ text labelText ]


numberInput : Int -> (String -> Msg) -> Int -> Int -> Int -> Html Msg
numberInput numberValue message min max step =
    div [ class "col-xs-6" ]
        [ input
            [ type_ "number"
            , class "form-control"
            , numberValue |> toString |> value
            , onInput message
            , min |> toString |> Html.Attributes.min
            , max |> toString |> Html.Attributes.max
            , step |> toString |> Html.Attributes.step
            ]
            []
        ]


controls : ScenarioID -> Scenario -> List (Html Msg)
controls id scenario =
    [ div [ class "form-horizontal" ]
        [ h2 [] [ text "Parameters" ]
        , div [ class "form-group" ]
            [ controlLabel "Months"
            , numberInput scenario.months
                (SetScenario SetMonths id)
                1
                100
                1
            ]
        , div [ class "form-group" ]
            [ controlLabel "Churn Rate (%)"
            , numberInput (Math.percentInt scenario.churnRate)
                (SetScenario SetChurnRate id)
                1
                100
                1
            ]
        , div [ class "form-group" ]
            [ controlLabel "Customer Growth Type"
            , div [ class "col-sm-6" ]
                [ select
                    [ class "form-control"
                    , onSelect (\s -> (SetScenario SetGrowthType id) (Maybe.withDefault "" s))
                    ]
                    [ option [ value "relative" ] [ text "Relative (%)" ]
                    , option [ value "absolute" ] [ text "Absolute" ]
                    ]
                ]
            ]
        , div [ class "form-group" ]
            [ controlLabel <| "Customers at Start"
            , numberInput
                (case scenario.customerGrowth of
                    Model.Absolute s _ ->
                        s

                    Model.Relative s _ ->
                        s
                )
                (SetScenario SetCustomerStart id)
                10
                1000
                10
            ]
        , div [ class "form-group" ]
            [ controlLabel <|
                "Customer Growth per Month"
                    ++ (case scenario.customerGrowth of
                            Model.Relative _ _ ->
                                " (%)"

                            Model.Absolute _ _ ->
                                ""
                       )
            , numberInput
                (case scenario.customerGrowth of
                    Model.Absolute _ g ->
                        g

                    Model.Relative _ g ->
                        (round <| g * 100)
                )
                (SetScenario SetCustomerGrowth id)
                0
                1000
                10
            ]
        , div [ class "form-group" ]
            [ controlLabel "Revenue per Customer per Month"
            , numberInput scenario.revenue
                (SetScenario SetRevenue id)
                0
                1000
                10
            ]
        , div [ class "form-group" ]
            [ controlLabel "Customer Acquisition Cost"
            , numberInput scenario.cac
                (SetScenario SetCAC id)
                0
                5000
                5
            ]
        , div [ class "form-group" ]
            [ controlLabel "Gross Margin (%)"
            , numberInput (scenario.revenueGrossMargin * 100 |> round)
                (SetScenario SetMargin id)
                0
                100
                5
            ]
        ]
    ]


controlsHelp : List (Html Msg)
controlsHelp =
    [ h4 [] [ text "Explanation of Parameters" ]
    , dl []
        [ dt [] [ text "Months" ]
        , dd [] [ text "Length of business forecast" ]
        , dt [] [ text "Churn Rate" ]
        , dd [] [ text "Percentage of customers leaving monthly" ]
        , dt [] [ text "Customer Growth" ]
        , dd []
            [ text "With absolute growth X users join the platform every month. "
            , a [ href "https://en.wikipedia.org/wiki/Cohort_(statistics)" ]
                [ text "(in cohorts)" ]
            ]
        , dd []
            [ text "With relative growth the user base will grow by X% every month."
            ]
        , dt [] [ text "Customer Growth per Month" ]
        , dd [] [ text "Number of customers signing up in one month, either relative or absolute, depending on the setting." ]
        , dt [] [ text "Revenue per customer per Month" ]
        , dd [] [ text "Revenue for one customer through subscription fees or similar" ]
        , dt [] [ text "Customer Acquisition Cost" ]
        , dd [] [ text "Cost related to acquiring one customer" ]
        ]
    ]


numbers : Scenario -> List (Html Msg)
numbers scenario =
    let
        months =
            List.range 1 scenario.months

        breakEven =
            Math.breakEven scenario

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
                    , [ Math.customerCohorts scenario month
                            |> round
                            |> toString
                            |> text
                      ]
                        |> td []
                    , Math.revenueCohorts scenario month |> humanizeValue |> td []
                    , Math.grossMargin scenario month |> humanizeValue |> td []
                    , Math.expenses scenario |> toFloat |> humanizeValue |> td []
                    , Math.earnings scenario month |> humanizeValue |> td []
                    , Math.cumulativeEarnings scenario month |> humanizeValue |> td []
                    ]

        rows =
            List.map row (Math.months scenario.months)
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


results : Scenario -> List (Html Msg)
results scenario =
    let
        breakEven =
            Math.breakEven scenario |> humanize

        earningsBreakEven =
            Math.earningsBreakEven scenario |> humanize

        averageLife =
            Math.averageLife scenario |> humanizeDuration

        cltv =
            Math.cltv scenario |> toFloat |> humanizeValue

        ltvcac =
            Math.ltvcac scenario |> humanizeRatio

        minimumCumulativeEarnings =
            Math.minimumCumulativeEarnings scenario |> humanizeValue
    in
        [ h2 [] [ text "Results" ]
        , dl []
            [ dt [] [ text "EBIT positive" ]
            , dd [] earningsBreakEven
            , dt [] [ text "Cumulative EBIT positive" ]
            , dd [] breakEven
            , dt [] [ text "Average Customer Life" ]
            , dd [] averageLife
            , dt [] [ text "Customer Lifetime Value" ]
            , dd [] cltv
            , dt [] [ text "LTV over CAC" ]
            , dd [] ltvcac
            , dt [] [ text "Minimum Cumulative EBIT" ]
            , dd [] minimumCumulativeEarnings
            ]
        ]


resultsHelp : List (Html Msg)
resultsHelp =
    [ h4 [] [ text "Explanation of Results" ]
    , dl []
        [ dt [] [ text "EBIT" ]
        , dd []
            [ text "Earnings before interest and tax. "
            , a [ href "https://en.wikipedia.org/wiki/Earnings_before_interest_and_taxes" ] [ text "(Wikipedia)" ]
            ]
        , dt [] [ text "EBIT positive" ]
        , dd [] [ text "Month at which EBIT cross 0." ]
        , dt [] [ text "Cumulative EBIT positive" ]
        , dd [] [ text "Month at which cumulative EBIT cross 0." ]
        , dt [] [ text "Average Customer Lifetime" ]
        , dd [] [ text "Average number of months a customer stays with this business." ]
        , dt [] [ text "Customer Lifetime Value" ]
        , dd [] [ text "Average revenue earned through one customer over the whole lifetime." ]
        , dt [] [ text "LTV over CAC" ]
        , dd [] [ text "Ratio of Lifetime Value over Customer Acquisition Cost. Less than 1 means acquisition will not yield in profit." ]
        , dt [] [ text "Minimum Cumulative EBIT" ]
        , dd [] [ text "Lowest point in cumulative EBIT. Bank account needs to be able to shoulder this." ]
        ]
    ]


help : List (Html Msg)
help =
    [ h2 [] [ text "Help" ]
    , div [ class "row" ]
        [ div [ class "col-md-6" ] controlsHelp
        , div [ class "col-md-6" ] resultsHelp
        ]
    ]


footer : Html Msg
footer =
    p []
        [ text "Created by "
        , a [ href "https://www.justus.pw" ] [ text "Justus Perlwitz" ]
        , text " / "
        , a [ href "mailto:hello@justus.pw" ] [ text "hello@justus.pw" ]
        ]
