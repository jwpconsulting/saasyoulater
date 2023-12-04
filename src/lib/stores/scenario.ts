import type { Writable, Readable, Updater } from "svelte/store";
import { derived, writable } from "svelte/store";
import type { Scenario } from "$lib/types";

// Default values here are derived from newScenario in applicaton/Model.elm
const defaultScenario = (): Scenario => {
    return {
        months: 24,
        customerGrowth: {
            startValue: 10,
            growthRate: 0.4,
            churnRate: 0.03,
        },
        revenue: 30,
        revenueGrossMargin: 0.5,
        cac: 45,
        fixedCost: 100,
    };
};

const _currentScenario = writable<Scenario>(defaultScenario());
const toInternal = ($currentScenario: Scenario) => {
    return {
        ...$currentScenario,
        customerGrowth: {
            ...$currentScenario.customerGrowth,
            growthRate: $currentScenario.customerGrowth.growthRate / 100,
            churnRate: $currentScenario.customerGrowth.churnRate / 100,
        },
        revenueGrossMargin: $currentScenario.revenueGrossMargin / 100,
    };
};
const toExternal = ($currentScenario: Scenario) => {
    return {
        ...$currentScenario,
        customerGrowth: {
            ...$currentScenario.customerGrowth,
            growthRate: $currentScenario.customerGrowth.growthRate * 100,
            churnRate: $currentScenario.customerGrowth.churnRate * 100,
        },
        revenueGrossMargin: $currentScenario.revenueGrossMargin * 100,
    };
};
export const currentScenario: Writable<Scenario> = {
    subscribe: derived<Readable<Scenario>, Scenario>(
        _currentScenario,
        ($currentScenario, set) => set(toExternal($currentScenario)),
    ).subscribe,
    set: ($currentScenario: Scenario) => toInternal($currentScenario),
    // TODO implement me
    update: (updater: Updater<Scenario>) => {
        console.error(updater);
        throw new Error("Not implemented");
    },
};
