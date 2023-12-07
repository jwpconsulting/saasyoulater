/*
 * Types used Saas You Later
 */
export type Float = number;
export type Int = number;
export type StartValue = Int;
export type GrowthRate = Float;
export type ChurnRate = Float;
export type Month = Int;
export type Money = Int;
export type Percentage = Float;
export type EffectiveGrowth = number;

export interface CustomerGrowth {
    // Add a setter here that ensures 0 <= startValue
    startValue: StartValue;
    // Add a setter here that ensures 0 <= growthRate <= 100
    growthRate: GrowthRate;
    // Add a setter here that ensures 0 <= churnRate <= 100
    churnRate: ChurnRate;
}

export interface Scenario {
    // Add a setter here that ensures that months > 0
    months: Month;
    // Add a setter here that ensures 0 <= revenue
    revenue: Money;
    customerGrowth: CustomerGrowth;
    // Add a setter here that ensures 0 <= revenueGrossMargin <= 100
    revenueGrossMargin: Percentage;
    // Add a setter here that ensures 0 <= cac
    cac: Money;
    // Add a setter here that ensures 0 <= fixedCost
    fixedCost: Money;
    name?: string;
    comment?: string;
}

export interface Datum {
    month: Month;
    customers: number;
    revenue: number;
    grossMargin: number;
    expenses: number;
    ebit: number;
    cumulativeEbit: number;
}

export interface Results {
    data: Datum[];
    breakEven: Money | undefined;
    earningsBreakEven: Money | undefined;
    averageLife: Money;
    cltv: Money;
    ltvcac: Money;
    minimumCumulativeEarnings: Money;
}

type Currency = "USD" | "AUD" | "EUR" | "INR" | "JPY" | "TRY" | "UAH" | "VND";

export type ScenarioId = string;

export interface Model {
    scenarios: Map<ScenarioId, Scenario>;
    currentScenario: ScenarioId | undefined;
    currency: Currency;
}
