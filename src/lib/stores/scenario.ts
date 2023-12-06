import { writable } from "svelte/store";
import type { Scenario } from "$lib/types";

// Default values here are derived from newScenario in applicaton/Model.elm
const defaultScenario = (): Scenario => {
    return {
        months: 24,
        customerGrowth: {
            startValue: 10,
            growthRate: 40,
            churnRate: 3,
        },
        revenue: 30,
        revenueGrossMargin: 50,
        cac: 45,
        fixedCost: 100,
    };
};

export const currentScenario = writable<Scenario>(defaultScenario());
