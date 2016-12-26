module View exposing (view)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model, Scenario, ScenarioID, Currency)
import Dict
import Math
import Msg exposing (..)
import Humanize exposing (..)
import Localize exposing (localizeCurrency, currencyName)
import Encode exposing (encodeCurrency)


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
                (case scenario of
                    Nothing ->
                        [ div [ class "col-xs-12" ]
                            [ text "Loading scenarios" ]
                        ]

                    Just ( id, scenario ) ->
                        [ div [ class "col-xs-6 col-md-3" ]
                            (controls model id scenario)
                        , div [ class "col-xs-6 col-md-2 col-md-push-7" ] <|
                            (results model.currency scenario)
                                ++ options model
                        , div [ class "col-xs-12 col-md-7 col-md-pull-2" ]
                            (numbers model.currency scenario)
                        ]
                )
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


scenarioTab : Maybe ScenarioID -> ScenarioID -> Html Msg
scenarioTab currentScenario id =
    let
        current =
            case currentScenario of
                Nothing ->
                    False

                Just current ->
                    current == id
    in
        li
            [ class <|
                if current then
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


type LabelType
    = Percentage
    | Currency
    | Number


controlLabel : Model -> LabelType -> String -> Html Msg
controlLabel model labelType labelText =
    let
        suff =
            case labelType of
                Percentage ->
                    " (%)"

                Currency ->
                    " (" ++ localizeCurrency model.currency ++ ")"

                Number ->
                    ""
    in
        label [ class "control-label col-xs-6" ] [ text <| labelText ++ suff ]


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


controls : Model -> Int -> Scenario -> List (Html Msg)
controls model id scenario =
    [ div [ class "form-horizontal" ]
        [ h2 [] [ text "Parameters" ]
        , div [ class "form-group" ]
            [ controlLabel model Number "Months"
            , numberInput scenario.months
                (SetScenario SetMonths id)
                1
                100
                1
            ]
        , div [ class "form-group" ]
            [ controlLabel model Percentage "Churn Rate"
            , numberInput
                (Math.percentInt scenario.customerGrowth.churnRate)
                (SetScenario SetChurnRate id)
                1
                100
                1
            ]
        , div [ class "form-group" ]
            [ controlLabel model Number "Customers at Start"
            , numberInput
                scenario.customerGrowth.startValue
                (SetScenario SetCustomerStart id)
                10
                1000
                10
            ]
        , div [ class "form-group" ]
            [ controlLabel model Percentage "Customer Growth per Month"
            , numberInput
                (Math.percentInt scenario.customerGrowth.growthRate)
                (SetScenario SetCustomerGrowth id)
                0
                1000
                10
            ]
        , div [ class "form-group" ]
            [ controlLabel model Currency "Revenue per Customer per Month"
            , numberInput scenario.revenue
                (SetScenario SetRevenue id)
                0
                1000
                10
            ]
        , div [ class "form-group" ]
            [ controlLabel model Currency "Customer Acquisition Cost"
            , numberInput scenario.cac
                (SetScenario SetCAC id)
                0
                5000
                5
            ]
        , div [ class "form-group" ]
            [ controlLabel model Percentage "Gross Margin"
            , numberInput (scenario.revenueGrossMargin * 100 |> round)
                (SetScenario SetMargin id)
                0
                100
                5
            ]
        , div [ class "form-group" ]
            [ controlLabel model Currency "Fixed Cost "
            , numberInput (scenario.fixedCost)
                (SetScenario SetFixedCost id)
                0
                10000
                100
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
            [ text "With relative growth the user base will grow by X% every month."
            ]
        , dt [] [ text "Customer Growth per Month" ]
        , dd [] [ text "Number of customers signing up in one month, either relative or absolute, depending on the setting." ]
        , dt [] [ text "Revenue per customer per Month" ]
        , dd [] [ text "Revenue for one customer through subscription fees or similar" ]
        , dt [] [ text "Customer Acquisition Cost" ]
        , dd []
            [ text "Customer Acquisition Cost is the cost associated in convincing a customer to subscribe to your SaaS. Typically this will be your marketing budget per customer."
            , a [ href "https://en.wikipedia.org/wiki/Customer_acquisition_cost" ]
                [ text " (Wikipedia)" ]
            ]
        , dt [] [ text "Gross Margin" ]
        , dd []
            [ text "Difference between revenue and cost."
            , a [ href "https://en.wikipedia.org/wiki/Gross_margin" ]
                [ text " (Wikipedia)" ]
            ]
        , dt [] [ text "Fixed cost" ]
        , dd []
            [ text "Business expenses that are not dependent on the amount of customers."
            , a [ href "https://en.wikipedia.org/wiki/Fixed_cost" ]
                [ text " (Wikipedia)" ]
            ]
        ]
    ]


numbers : Currency -> Scenario -> List (Html Msg)
numbers currency scenario =
    let
        hv =
            humanizeValue currency

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
                    , [ Math.customers scenario.customerGrowth month |> toString |> text
                      ]
                        |> td []
                    , Math.revenue scenario month |> hv |> td []
                    , Math.grossMargin scenario month |> hv |> td []
                    , Math.expenses scenario month |> hv |> td []
                    , Math.earnings scenario month |> hv |> td []
                    , Math.cumulativeEarnings scenario month |> hv |> td []
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


options : Model -> List (Html Msg)
options model =
    [ h3 [] [ text "Options" ]
    , div [ class "form-group" ]
        [ label [] [ text "Currency" ]
        , div []
            [ select
                [ class "form-control"
                , onInput SetCurrency
                ]
              <|
                (List.map (currencyOption model.currency)
                    Model.currencies
                )
            ]
        ]
    , Maybe.withDefault (span [] []) <|
        Maybe.map
            (\s ->
                a
                    [ href "#"
                    , onClick (DeleteScenario s)
                    , class "btn btn-danger btn-block"
                    ]
                    [ text "Delete Scenario" ]
            )
            model.currentScenario
    ]


currencyOption : Currency -> Currency -> Html Msg
currencyOption currentCurrency currency =
    option
        [ value <| encodeCurrency currency
        , selected <| currentCurrency == currency
        ]
        [ text <|
            currencyName currency
                ++ " ("
                ++ localizeCurrency currency
                ++ ")"
        ]


results : Currency -> Scenario -> List (Html Msg)
results currency scenario =
    let
        hv =
            humanizeValue currency

        breakEven =
            Math.breakEven scenario |> humanize

        earningsBreakEven =
            Math.earningsBreakEven scenario |> humanize

        averageLife =
            Math.averageLife scenario |> humanizeDuration

        cltv =
            Math.cltv scenario |> hv

        ltvcac =
            Math.ltvcac scenario |> humanizeRatio

        minimumCumulativeEarnings =
            Math.minimumCumulativeEarnings scenario |> hv
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
