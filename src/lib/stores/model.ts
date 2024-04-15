import type { Model, ScenarioId } from "$lib/types";
import { derived, readonly, writable } from "svelte/store";
import type { Datum, Results, Scenario } from "$lib/types";
import * as math from "$lib/math";


function defaultModel(): Model {
    return {
        scenarios: new Map(),
        currentScenario: undefined,
        currency: "USD",
    };
}

const _model = writable<Model>(defaultModel());
export const model = readonly(_model);

export function chooseScenario(scenarioId: ScenarioId) {
    _model.update(($model) => {
        if (!$model.scenarios.has(scenarioId)) {
            console.error(`${scenarioId} was not found in model`);
        }
        return {
            ...$model,
            currentScenario: scenarioId,
        };
    });
}

// TODO
export function setScenario(scenarioId: ScenarioId, scenario: Scenario) {
}
// chooseScenario(scenarioId: ScenarioId)
// newScenario
// setCurrency(currency: Currency)
// deleteScenario(scenarioId: ScenarioId)
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

export const currentResults = derived<typeof currentScenario, Results>(
    currentScenario,
    ($currentScenario, set) => {
        const months = math.months($currentScenario.months);
        const data: Datum[] = months.map((month: number) => {
            return {
                month,
                customers: math.customers(
                    $currentScenario.customerGrowth,
                    month,
                ),
                revenue: math.revenue($currentScenario, month),
                grossMargin: math.grossMargin($currentScenario, month),
                expenses: math.expenses($currentScenario, month),
                ebit: math.earnings($currentScenario, month),
                cumulativeEbit: math.cumulativeEarnings(
                    $currentScenario,
                    month,
                ),
            };
        });
        set({
            data,
            breakEven: math.breakEven($currentScenario),
            earningsBreakEven: math.earningsBreakEven($currentScenario),
            averageLife: math.averageLife($currentScenario),
            cltv: math.cltv($currentScenario),
            ltvcac: math.ltvcac($currentScenario),
            minimumCumulativeEarnings:
                math.minimumCumulativeEarnings($currentScenario),
        });
    },
);
