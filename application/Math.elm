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

import Model exposing (Model)


cohortMonth : Int -> Int -> Float
cohortMonth cohort month =
    month - cohort |> toFloat


churn : Float -> Float -> Float
churn churnRate month =
    (1 - churnRate) ^ month


customers : Int -> Float -> Float -> Float
customers customerGrowth churnRate month =
    toFloat customerGrowth * churn churnRate month


customerCohort : Model -> Int -> Int -> Float
customerCohort model month cohort =
    let
        m =
            cohortMonth cohort month
    in
        if m >= 0 then
            customers model.customerGrowth model.churnRate m
        else
            0.0


customerCohorts : Model -> Int -> Float
customerCohorts model month =
    List.map (customerCohort model month) (List.range 1 model.months)
        |> List.foldl (+) 0


revenueCohort : Model -> Int -> Int -> Float
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


revenueCohorts : Model -> Int -> Float
revenueCohorts model month =
    List.map (revenueCohort model month) (List.range 1 model.months)
        |> List.foldl (+) 0


revenueCost : Model -> Int -> Float
revenueCost model month =
    revenueCohorts model month * (1 - model.revenueGrossMargin)


grossMargin : Model -> Int -> Float
grossMargin model month =
    revenueCohorts model month * model.revenueGrossMargin


expenses : Model -> Int
expenses model =
    model.customerGrowth * model.cac + model.opCost


earnings : Model -> Int -> Float
earnings model month =
    grossMargin model month - toFloat (expenses model)


cumulativeEarnings : Model -> Int -> Float
cumulativeEarnings model month =
    List.map (earnings model) (List.range 1 month) |> List.foldl (+) 0


earningsBreakEvenWithMonth : Model -> Int -> Maybe Int
earningsBreakEvenWithMonth model month =
    if earnings model month >= 0 then
        Just month
    else
        (if month >= model.months then
            Nothing
         else
            earningsBreakEvenWithMonth model (month + 1)
        )


earningsBreakEven : Model -> Maybe Int
earningsBreakEven model =
    earningsBreakEvenWithMonth model 1


breakEvenWithMonth : Model -> Int -> Maybe Int
breakEvenWithMonth model month =
    if cumulativeEarnings model month >= 0 then
        Just month
    else
        (if month >= model.months then
            Nothing
         else
            breakEvenWithMonth model (month + 1)
        )


breakEven : Model -> Maybe Int
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


averageLife : Model -> Int
averageLife model =
    round (1 / model.churnRate)


cltv : Model -> Int
cltv model =
    averageLife model * model.revenue


ltvcac : Model -> Float
ltvcac model =
    toFloat (cltv model) / toFloat model.cac


minimumCumulativeEarnings : Model -> Float
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
