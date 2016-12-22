module Math exposing (..)

import Model exposing (..)


monthRange : Int -> List Int
monthRange =
    List.range 1


cohortMonth : Int -> Int -> Float
cohortMonth cohort month =
    month - cohort |> toFloat


customers : CustomerGrowth -> ChurnRate -> Int -> Month
customers customerGrowth churnRate month =
    case customerGrowth of
        Relative start growth ->
            round (toFloat start * ((1 + (growth - churnRate)) ^ (toFloat <| month - 1)))


revenue : Scenario -> Month -> Int
revenue model month =
    case model.customerGrowth of
        Relative _ _ ->
            (customers model.customerGrowth model.churnRate month) * (model.revenue)


revenueCost : Scenario -> Int -> Int
revenueCost model month =
    toFloat (revenue model month) * (1 - model.revenueGrossMargin) |> round


grossMargin : Scenario -> Month -> Int
grossMargin model month =
    round <| toFloat (revenue model month) * model.revenueGrossMargin


expenses : Scenario -> Month -> Int
expenses model month =
    let
        c =
            customers model.customerGrowth model.churnRate
    in
        max 0 <| ((c month) - (c <| month - 1)) * model.cac


earnings : Scenario -> Month -> Int
earnings model month =
    grossMargin model month - expenses model month


cumulativeEarnings : Scenario -> Month -> Int
cumulativeEarnings model month =
    List.map (earnings model) (List.range 1 month) |> List.foldl (+) 0


earningsBreakEvenWithMonth : Scenario -> Month -> Maybe Int
earningsBreakEvenWithMonth model month =
    if earnings model month >= 0 then
        Just month
    else
        (if month >= model.months then
            Nothing
         else
            earningsBreakEvenWithMonth model (month + 1)
        )


earningsBreakEven : Scenario -> Maybe Month
earningsBreakEven model =
    earningsBreakEvenWithMonth model 1


breakEvenWithMonth : Scenario -> Month -> Maybe Month
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


months : Month -> List Int
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


minimumCumulativeEarnings : Scenario -> Int
minimumCumulativeEarnings model =
    List.map (cumulativeEarnings model) (monthRange model.months)
        |> List.minimum
        |> Maybe.withDefault 0


percentInt : Float -> Int
percentInt percent =
    percent * 100 |> round
