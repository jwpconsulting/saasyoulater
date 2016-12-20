module Math
    exposing
        ( customerCohorts
        , revenueCohorts
        , grossMargin
        , expenses
        , cumulativeEarnings
        , earnings
        , months
        , earningsBreakEven
        , breakEven
        , averageLife
        , cltv
        , ltvcac
        , minimumCumulativeEarnings
        )

import Model exposing (Scenario)


cohortMonth : Int -> Int -> Float
cohortMonth cohort month =
    month - cohort |> toFloat


churn : Float -> Float -> Float
churn churnRate month =
    (1 - churnRate) ^ month


customers : Int -> Float -> Float -> Float
customers customerGrowth churnRate month =
    toFloat customerGrowth * churn churnRate month


customerCohort : Scenario -> Int -> Int -> Float
customerCohort model month cohort =
    let
        m =
            cohortMonth cohort month
    in
        if m >= 0 then
            customers model.customerGrowth model.churnRate m
        else
            0.0


customerCohorts : Scenario -> Int -> Float
customerCohorts model month =
    List.map (customerCohort model month) (List.range 1 model.months)
        |> List.foldl (+) 0


revenueCohort : Scenario -> Int -> Int -> Float
revenueCohort model month cohort =
    let
        customers =
            customerCohort model month cohort

        m =
            cohortMonth cohort month

        revenue =
            toFloat model.revenue
    in
        customers * revenue


revenueCohorts : Scenario -> Int -> Float
revenueCohorts model month =
    List.map (revenueCohort model month) (List.range 1 model.months)
        |> List.foldl (+) 0


revenueCost : Scenario -> Int -> Float
revenueCost model month =
    revenueCohorts model month * (1 - model.revenueGrossMargin)


grossMargin : Scenario -> Int -> Float
grossMargin model month =
    revenueCohorts model month * model.revenueGrossMargin


expenses : Scenario -> Int
expenses model =
    model.customerGrowth * model.cac + model.opCost


earnings : Scenario -> Int -> Float
earnings model month =
    grossMargin model month - toFloat (expenses model)


cumulativeEarnings : Scenario -> Int -> Float
cumulativeEarnings model month =
    List.map (earnings model) (List.range 1 month) |> List.foldl (+) 0


earningsBreakEvenWithMonth : Scenario -> Int -> Maybe Int
earningsBreakEvenWithMonth model month =
    if earnings model month >= 0 then
        Just month
    else
        (if month >= model.months then
            Nothing
         else
            earningsBreakEvenWithMonth model (month + 1)
        )


earningsBreakEven : Scenario -> Maybe Int
earningsBreakEven model =
    earningsBreakEvenWithMonth model 1


breakEvenWithMonth : Scenario -> Int -> Maybe Int
breakEvenWithMonth model month =
    if cumulativeEarnings model month >= 0 then
        Just month
    else
        (if month >= model.months then
            Nothing
         else
            breakEvenWithMonth model (month + 1)
        )


breakEven : Scenario -> Maybe Int
breakEven model =
    breakEvenWithMonth model 1


linspace : Int -> Int -> Int -> List Int
linspace start stop n =
    case n of
        1 ->
            [ stop ]

        _ ->
            let
                h =
                    (toFloat (stop - start)) / (toFloat (n - 1))
            in
                (List.range 0 (n - 1))
                    |> List.map toFloat
                    |> List.map (\n -> (toFloat start) + n * h)
                    |> List.map round


months : Int -> List Int
months months =
    linspace 1 months (min months 12)


averageLife : Scenario -> Int
averageLife model =
    round (1 / model.churnRate)


cltv : Scenario -> Int
cltv model =
    averageLife model * model.revenue


ltvcac : Scenario -> Float
ltvcac model =
    toFloat (cltv model) / toFloat model.cac


minimumCumulativeEarnings : Scenario -> Float
minimumCumulativeEarnings model =
    let
        minimum =
            List.map (cumulativeEarnings model) (List.range 1 model.months) |> List.minimum
    in
        case minimum of
            Nothing ->
                0

            Just value ->
                value
