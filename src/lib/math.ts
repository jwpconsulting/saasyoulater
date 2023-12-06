import type {
    Float,
    Int,
    Month,
    CustomerGrowth,
    Scenario,
    EffectiveGrowth,
    Money,
} from "$lib/types";

// firstMonth : Month
export const firstMonth: Month = 1;

// monthRange : Month -> List Month
export function monthRange(month: Month): Month[] {
    return [...Array(month).keys()].map((i) => i + firstMonth);
}

// cohortMonth : Int -> Int -> Float
export function cohortMonth(cohort: Int, month: Int): Float {
    return month - cohort;
}

// effectiveGrowth : CustomerGrowth -> EffectiveGrowth
export function effectiveGrowth(
    customerGrowth: CustomerGrowth,
): EffectiveGrowth {
    return 1 + (customerGrowth.growthRate - customerGrowth.churnRate);
}

// customers : CustomerGrowth -> Month -> Int
export function customers(customerGrowth: CustomerGrowth, month: Month): Int {
    return Math.round(
        customerGrowth.startValue *
            Math.pow(effectiveGrowth(customerGrowth), month - 1),
    );
}

// revenue : Scenario -> Month -> Int
export function revenue(scenario: Scenario, month: Month): Int {
    return customers(scenario.customerGrowth, month) * scenario.revenue;
}

// grossMargin : Scenario -> Month -> Money
export function grossMargin(model: Scenario, month: Month): Money {
    return Math.round(revenue(model, month) * model.revenueGrossMargin);
}

// customerGrowth : CustomerGrowth -> Month -> Int
export function customerGrowth(
    customerGrowth: CustomerGrowth,
    month: Month,
): Int {
    const c = customers.bind(null, customerGrowth);
    return Math.max(0, c(month) - c(month - 1));
}

// customerAcquisitionCost : Scenario -> Month -> Money
export function customerAcquisitionCost(
    scenario: Scenario,
    month: Month,
): Money {
    const customersLastMonth = customers(scenario.customerGrowth, month - 1);

    const customersAdded =
        customersLastMonth * scenario.customerGrowth.growthRate;
    return Math.round(customersAdded) * scenario.cac;
}

// expenses : Scenario -> Month -> Int
export function expenses(scenario: Scenario, month: Month): Int {
    return customerAcquisitionCost(scenario, month) + scenario.fixedCost;
}

// earnings : Scenario -> Month -> Int
export function earnings(model: Scenario, month: Month): Int {
    return grossMargin(model, month) - expenses(model, month);
}

// cumulativeEarnings : Scenario -> Month -> Int
export function cumulativeEarnings(model: Scenario, month: Month): Int {
    // List.map (earnings model) (List.range 1 month) |> List.foldl (+) 0
    return monthRange(month)
        .map((m) => earnings(model, m))
        .reduce((a, b) => a + b, 0);
}

// earningsBreakEvenWithMonth : Scenario -> Month -> Maybe Int
export function earningsBreakEvenWithMonth(
    model: Scenario,
    month: Month,
): Int | undefined {
    // if earnings model month >= 0 then
    if (earnings(model, month) >= 0) {
        // Just month
        return month;
        // else
    } else {
        // (if month >= model.months then
        if (month >= model.months) {
            // Nothing
            return undefined;
            //else
        } else {
            // earningsBreakEvenWithMonth model (month + 1)
            return earningsBreakEvenWithMonth(model, month + 1);
        }
    }
}

// earningsBreakEven : Scenario -> Maybe Month
export function earningsBreakEven(model: Scenario): Month | undefined {
    return earningsBreakEvenWithMonth(model, 1);
}

// breakEvenWithMonth : Scenario -> Month -> Maybe Month
export function breakEvenWithMonth(
    model: Scenario,
    month: Month,
): Month | undefined {
    // if cumulativeEarnings model month >= 0 then
    if (cumulativeEarnings(model, month) >= 0) {
        // Just month
        return month;
        // else
    } else {
        // (if month >= model.months then
        if (month >= model.months) {
            // Nothing
            return undefined;
            // else
        } else {
            // breakEvenWithMonth model (month + 1)
            return breakEvenWithMonth(model, month + 1);
        }
    }
}

// breakEven : Scenario -> Maybe Int
export function breakEven(model: Scenario): Int | undefined {
    return breakEvenWithMonth(model, 1);
}

// linspace : Int -> Int -> Int -> List Int
export function linspace(start: Int, stop: Int, n: Int): Int[] {
    // case n of
    // 1 ->
    if (n == 1) {
        // [ stop ]
        return [stop];
        // _ ->
    } else {
        // let
        //     h =
        //         (toFloat (stop - start)) / (toFloat (n - 1))
        const h = (stop - start) / (n - 1);
        // in
        // (List.range 0 (n - 1))
        return (
            [...Array(n).keys()]
                // |> List.map toFloat
                // |> List.map (\n -> (toFloat start) + n * h)
                // |> List.map round
                .map((n) => Math.round(start + n * h))
        );
    }
}

// months : Month -> List Int
export function months(months: Month): Int[] {
    // linspace 1 months (min months 12)
    return linspace(1, months, Math.min(months, 12));
}

// averageLife : Scenario -> Int
export function averageLife(model: Scenario): Int {
    // round (1 / model.customerGrowth.churnRate)
    return Math.round(1 / model.customerGrowth.churnRate);
}

// cltv : Scenario -> Int
export function cltv(model: Scenario): Int {
    // averageLife model * model.revenue
    return averageLife(model) * model.revenue;
}

// ltvcac : Scenario -> Float
export function ltvcac(model: Scenario): Float {
    // toFloat (cltv model) / toFloat model.cac
    return cltv(model) / model.cac;
}

// minimumCumulativeEarnings : Scenario -> Int
export function minimumCumulativeEarnings(model: Scenario): Int {
    // List.map (cumulativeEarnings model) (monthRange model.months)
    //     |> List.minimum
    //     |> Maybe.withDefault 0
    return monthRange(model.months)
        .map(cumulativeEarnings.bind(null, model))
        .reduce((a, b) => Math.min(a, b), 0);
}

// percentInt : Float -> Int
export function percentInt(percent: Float): Int {
    // percent * 100 |> round
    return Math.round(percent * 100);
}
