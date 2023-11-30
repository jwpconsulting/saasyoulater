import { writable } from "svelte/store";
// TODO
// Rates are stored as percentages, but it would be better if they were stored
// as floats in [0, 1].
// TODO
// To support evaluating several models, we need to store the whole model as
// an object, instead of every single value.
//
//
interface CustomerGrowth {
    startValue: number;
    growthRate: number;
    churnRate: number;
}

// Default values here are derived from newScenario in applicaton/Model.elm
// Add a setter here that ensures that months > 0
export const months = writable(24);
export const customerGrowth = writable<CustomerGrowth>({
    // Add a setter here that ensures 0 <= startValue
    startValue: 10,
    // Add a setter here that ensures 0 <= growthRate <= 100
    growthRate: 40,
    // Add a setter here that ensures 0 <= churnRate <= 100
    churnRate: 3,
});
// Add a setter here that ensures 0 <= revenue
export const revenue = writable(30);
// Add a setter here that ensures 0 <= revenueGrossMargin <= 100
export const revenueGrossMargin = writable(50);
// Add a setter here that ensures 0 <= cac
export const cac = writable(45);
// Add a setter here that ensures 0 <= fixedCost
export const fixedCost = writable(100);

export const name = writable<string | undefined>(undefined);
export const comment = writable<string | undefined>(undefined);
