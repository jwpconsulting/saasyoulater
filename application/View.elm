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
                    Dict.toList model.scenarios
                )
                    ++ [ newTab ]
            ]
                ++ (case scenario of
                        Nothing ->
                            [ text "Loading scenarios" ]

                        Just ( id, scenario ) ->
                            [ div [ class "row" ]
                                [ div [ class "col-xs-6 col-md-2" ]
                                    [ (controls model id scenario) ]
                                , div [ class "col-xs-6 col-md-3 col-md-push-7" ] <|
                                    (results model.currency scenario)
                                        ++ options model id scenario
                                , div [ class "col-xs-12 col-md-7 col-md-pull-3" ]
                                    (numbers model.currency scenario)
                                ]
                            ]
                   )
                ++ [ hr [] [] ]
                ++ help
                ++ [ hr [] [], footer ]


newTab : Html Msg
newTab =
    li []
        [ a
            [ href "#"
            , onClick NewScenario
            ]
            [ text "+ Add a Scenario" ]
        ]


scenarioTab : Maybe ScenarioID -> ( ScenarioID, Scenario ) -> Html Msg
scenarioTab currentScenario ( scenarioID, scenario ) =
    let
        current =
            currentScenario
                |> Maybe.map (\current -> current == scenarioID)
                |> Maybe.withDefault False
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
                , onClick (ChooseScenario scenarioID)
                ]
                [ scenario.name
                    |> Maybe.map identity
                    |> Maybe.withDefault ("Scenario " ++ (toString scenarioID))
                    |> text
                ]
            ]


type LabelType
    = Percentage
    | Currency
    | Number


type NumberRange
    = NumberRange Int Int Int


labelText : Model -> LabelType -> String
labelText model labelType =
    case labelType of
        Percentage ->
            "%"

        Currency ->
            localizeCurrency model.currency

        Number ->
            ""


controlLabel : String -> Html Msg
controlLabel l =
    label [ class "control-label" ]
        [ (l) |> text ]


numberRange : NumberRange -> List (Html.Attribute Msg)
numberRange range =
    case range of
        NumberRange min max step ->
            [ min |> toString |> Html.Attributes.min
            , max |> toString |> Html.Attributes.max
            , step |> toString |> Html.Attributes.step
            ]


numberInput : String -> Int -> (String -> Msg) -> NumberRange -> Html Msg
numberInput addon numberValue message range =
    let
        i =
            input
                ([ type_ "number"
                 , class "form-control text-right"
                 , numberValue |> toString |> value
                 , onInput message
                 ]
                    ++ numberRange range
                )
                []
    in
        case addon of
            "" ->
                i

            _ ->
                div [ class "input-group" ]
                    [ span [ class "input-group-addon" ] [ text addon ]
                    , i
                    ]


controls : Model -> Int -> Scenario -> Html Msg
controls model id scenario =
    let
        lt =
            labelText model

        controlClass =
            class "form-group"

        controlDiv =
            div [ controlClass ]

        msg =
            SetScenario id
    in
        Html.form []
            [ h2 [] [ text "Controls" ]
            , controlDiv
                [ controlLabel "Months"
                , numberInput
                    (lt Number)
                    scenario.months
                    (msg SetMonths)
                  <|
                    NumberRange 1 100 1
                ]
            , controlDiv
                [ controlLabel "Churn Rate"
                , numberInput
                    (lt Percentage)
                    (Math.percentInt scenario.customerGrowth.churnRate)
                    (msg SetChurnRate)
                  <|
                    NumberRange 1 100 1
                ]
            , controlDiv
                [ controlLabel "Customers at Start"
                , numberInput
                    (lt Number)
                    scenario.customerGrowth.startValue
                    (msg SetCustomerStart)
                  <|
                    NumberRange 10 1000 10
                ]
            , controlDiv
                [ controlLabel "C. Growth MoM"
                , numberInput
                    (lt Percentage)
                    (Math.percentInt scenario.customerGrowth.growthRate)
                    (msg SetCustomerGrowth)
                  <|
                    NumberRange 0 1000 10
                ]
            , controlDiv
                [ controlLabel "Rev. per Customer"
                , numberInput
                    (lt Currency)
                    scenario.revenue
                    (msg SetRevenue)
                  <|
                    NumberRange 0 1000 10
                ]
            , controlDiv
                [ controlLabel "Gross Margin"
                , numberInput
                    (lt Percentage)
                    (scenario.revenueGrossMargin * 100 |> round)
                    (msg SetMargin)
                  <|
                    NumberRange 0 100 5
                ]
            , controlDiv
                [ controlLabel "CAC"
                , numberInput
                    (lt Currency)
                    scenario.cac
                    (msg SetCAC)
                  <|
                    NumberRange 0 5000 5
                ]
            , controlDiv
                [ controlLabel "Fixed Cost"
                , numberInput
                    (lt Currency)
                    scenario.fixedCost
                    (msg SetFixedCost)
                  <|
                    NumberRange 0 10000 100
                ]
            ]


wikiMsg : List (Html msg)
wikiMsg =
    [ text "Wikipedia Article" ]


controlsHelp : List (Html Msg)
controlsHelp =
    [ h4 [] [ text "Explanation of Controls" ]
    , dl []
        [ dt [] [ text "Months" ]
        , dd [] [ text "Length of business forecast" ]
        , dt [] [ text "Churn Rate" ]
        , dd [] [ text "Percentage of customers leaving monthly" ]
        , dt [] [ text "Customers at Start" ]
        , dd [] [ text "How many customers exist at start." ]
        , dt [] [ text "Customer Growth Month over Month (MoM)" ]
        , dd []
            [ text "Defines the monthly growth in percent, i.e., 3 % means your customer base will grow to 103% after a month." ]
        , dt [] [ text "Revenue per customer" ]
        , dd [] [ text "Monthly revenue from one customer" ]
        , dt [] [ text "Customer Acquisition Cost (CAC)" ]
        , dd []
            [ text "Customer Acquisition Cost is the cost associated in convincing a customer to subscribe to your SaaS. Typically this will be your marketing budget per customer."
            ]
        , dd []
            [ a [ href "https://en.wikipedia.org/wiki/Customer_acquisition_cost" ]
                wikiMsg
            ]
        , dt [] [ text "Gross Margin" ]
        , dd []
            [ text "Difference between revenue and cost." ]
        , dd []
            [ a [ href "https://en.wikipedia.org/wiki/Gross_margin" ]
                wikiMsg
            ]
        , dt [] [ text "Fixed cost" ]
        , dd []
            [ text "Business expenses that are not dependent on the amount of customers."
            ]
        , dd []
            [ a [ href "https://en.wikipedia.org/wiki/Fixed_cost" ]
                wikiMsg
            ]
        ]
    ]


numbers : Currency -> Scenario -> List (Html Msg)
numbers currency scenario =
    let
        hv =
            humanizeValue currency

        months =
            Math.monthRange scenario.months

        breakEven =
            Math.breakEven scenario

        row month =
            let
                trClass =
                    breakEven
                        |> Maybe.map
                            (\breakEvenMonth ->
                                if month >= breakEvenMonth then
                                    "success"
                                else
                                    "warning"
                            )
                        |> Maybe.withDefault "danger"
                        |> class

                tdright =
                    td [ class "text-right" ]
            in
                tr [ trClass ] <|
                    List.map tdright
                        ([ [ toString month |> text ]
                         , [ Math.customers scenario.customerGrowth month
                                |> toString
                                |> text
                           ]
                         ]
                            ++ List.map hv
                                [ Math.revenue scenario month
                                , Math.grossMargin scenario month
                                , Math.expenses scenario month
                                , Math.earnings scenario month
                                , Math.cumulativeEarnings scenario month
                                ]
                        )

        rows =
            List.map row (Math.months scenario.months)

        thstyled v =
            th [ class "text-center" ] [ text v ]
    in
        [ h2 [] [ text "Numbers" ]
        , div [ class "table-responsive" ]
            [ Html.table [ class "table table-hover table-condensed" ]
                [ thead []
                    [ tr [] <|
                        List.map thstyled
                            [ "Month"
                            , "Customers"
                            , "Revenue"
                            , "Gross Margin"
                            , "Expenses"
                            , "EBIT"
                            , "Cumulative EBIT"
                            ]
                    ]
                , tbody [] rows
                ]
            ]
        ]


options : Model -> ScenarioID -> Scenario -> List (Html Msg)
options model scenarioID scenario =
    let
        msg =
            SetScenario scenarioID
    in
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
        , div [ class "form-group" ]
            [ label [] [ text "Scenario Name" ]
            , input
                [ class "form-control"
                , placeholder "Scenario Name"
                , onInput (msg SetName)
                , value <| Maybe.withDefault "" <| scenario.name
                ]
                []
            ]
        , div [ class "form-group" ]
            [ label [] [ text "Comment" ]
            , textarea
                [ class "form-control"
                , placeholder "Scenario Comment"
                , onInput (msg SetComment)
                , scenario.comment
                    |> Maybe.withDefault ""
                    |> value
                ]
                []
            ]
        , Maybe.withDefault (span [] []) <|
            Maybe.map
                (\s ->
                    a
                        [ href "#"
                        , onClick (DeleteScenario s)
                        , class "btn btn-danger btn-xs btn-block"
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
            [ text "Earnings before interest and tax. " ]
        , dd []
            [ a [ href "https://en.wikipedia.org/wiki/Earnings_before_interest_and_taxes" ]
                wikiMsg
            ]
        , dt [] [ text "EBIT positive" ]
        , dd [] [ text "Month at which EBIT cross 0. This will be the first month you make profit (before tax and interest)" ]
        , dt [] [ text "Cumulative EBIT positive" ]
        , dd [] [ text "Month at which cumulative EBIT cross 0. This will be the first month your SaaS businesses net worth is positive, not counting taxes and interest." ]
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
