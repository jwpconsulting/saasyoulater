import type { Model, ScenarioId, Currency } from "$lib/types";
import type { Writable, Readable } from "svelte/store";
import { derived, readonly, writable } from "svelte/store";
import type { Datum, Results, Scenario } from "$lib/types";
import * as math from "$lib/math";

function defaultModel(): Model {
    return {
        scenarios: new Map([[1, defaultScenario()]]),
        currentScenario: 1,
        currency: "USD",
    };
}

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

const _model = writable<Model>(defaultModel());
export const model = readonly(_model);

export function setScenario(scenarioId: ScenarioId, scenario: Scenario) {
    _model.update(($model) => {
        if (!$model.scenarios.has(scenarioId)) {
            throw new Error("Scenario not found");
        }
        return {
            ...$model,
            scenarios: $model.scenarios.set(scenarioId, scenario),
        };
    });
}

export function chooseScenario(scenarioId: ScenarioId) {
    _model.update(($model) => {
        if (!$model.scenarios.has(scenarioId)) {
            throw new Error("Scenario not found");
        }
        return {
            ...$model,
            currentScenario: scenarioId,
        };
    });
}

// TODO
// newScenario
export function newScenario() {
    _model.update(($model) => {
        const newScenario = defaultScenario();
        const lastKey = [...$model.scenarios.keys()].at(-1) ?? 0;
        const scenarioId = lastKey + 1;
        const scenarios = $model.scenarios.set(scenarioId, newScenario);
        return {
            ...$model,
            scenarios,
            scenarioId,
        };
    });
}

export function setCurrency(currency: Currency) {
    _model.update(($model) => {
        return {
            ...$model,
            currency,
        };
    });
}

export function deleteScenario(scenarioId: ScenarioId) {
    _model.update(($model) => {
        const deleted = $model.scenarios.delete(scenarioId);
        if (!deleted) {
            throw new Error("scenarioId wasn't in scenarios");
        }
        return $model;
    });
}

const _currentScenario: Readable<Scenario | undefined> = derived<
    typeof model,
    Scenario | undefined
>(model, ($model, set) => {
    const current = $model.currentScenario;
    if (current === undefined) {
        set(undefined);
        return;
    }
    const scenario = $model.scenarios.get(current);
    if (scenario === undefined) {
        throw new Error("Expected scenario");
    }
    set(scenario);
});
export const currentScenario: Writable<Scenario | undefined> = {
    subscribe: _currentScenario.subscribe,
    set(newScenario: Scenario) {
        _model.update(($model) => {
            const { currentScenario } = $model;
            if (!currentScenario) {
                throw new Error("Expected currentScenario");
            }
            $model.scenarios.set(currentScenario, newScenario);
            return $model;
        });
    },
    update(updater: (v: Scenario | undefined) => Scenario) {
        _model.update(($model) => {
            const { currentScenario } = $model;
            if (!currentScenario) {
                throw new Error("Expected currentScenario");
            }
            const scenario = $model.scenarios.get(currentScenario);
            if (scenario === undefined) {
                throw new Error("Expected scenario");
            }
            $model.scenarios.set(currentScenario, updater(scenario));
            return $model;
        });
    },
};

export const currentResults = derived<
    typeof currentScenario,
    Results | undefined
>(currentScenario, ($currentScenario, set) => {
    if ($currentScenario === undefined) {
        set(undefined);
        return;
    }
    const months = math.months($currentScenario.months);
    const data: Datum[] = months.map((month: number) => {
        return {
            month,
            customers: math.customers($currentScenario.customerGrowth, month),
            revenue: math.revenue($currentScenario, month),
            grossMargin: math.grossMargin($currentScenario, month),
            expenses: math.expenses($currentScenario, month),
            ebit: math.earnings($currentScenario, month),
            cumulativeEbit: math.cumulativeEarnings($currentScenario, month),
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
});
