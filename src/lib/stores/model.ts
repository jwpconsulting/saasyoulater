import type { Model, ScenarioId, Currency } from "$lib/types";
import type { Writable, Readable } from "svelte/store";
import { derived, readonly, writable } from "svelte/store";
import type { Datum, Results, Scenario } from "$lib/types";
import * as math from "$lib/math";
import { scenarioSerializer } from "$lib/localStorage";

import { persisted } from "svelte-persisted-store";

function defaultModel(): Model {
    return {
        currentScenario: 1,
        currency: "usd",
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

const _scenarios = persisted<Map<number, Scenario> | undefined>(
    "scenarios",
    undefined,
    { serializer: scenarioSerializer },
);
export const scenarios = readonly(_scenarios);

export function setScenario(scenarioId: ScenarioId, scenario: Scenario) {
    _scenarios.update(($scenarios) => {
        if ($scenarios === undefined) {
            $scenarios = new Map();
        }
        if (!$scenarios.has(scenarioId)) {
            throw new Error("Scenario not found");
        }
        return $scenarios.set(scenarioId, scenario);
    });
}

export function chooseScenario(scenarioId: ScenarioId) {
    _scenarios.update(($scenarios) => {
        if ($scenarios === undefined) {
            throw new Error("Expected $scenarios");
        }
        if (!$scenarios.has(scenarioId)) {
            throw new Error("Scenario not found");
        }
        _model.update(($model) => {
            return {
                ...$model,
                currentScenario: scenarioId,
            };
        });
        return $scenarios;
    });
}

// TODO
// newScenario
export function newScenario() {
    _scenarios.update(($scenarios) => {
        if (!$scenarios) {
            throw new Error("Expected $scenarios");
        }
        const newScenario = defaultScenario();
        const lastKey = [...$scenarios.keys()].at(-1) ?? 0;
        const scenarioId = lastKey + 1;
        const scenarios = $scenarios.set(scenarioId, newScenario);
        _model.update(($model) => {
            return {
                ...$model,
                currentScenario: scenarioId,
            };
        });
        return scenarios;
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
    _scenarios.update(($scenarios) => {
        if ($scenarios === undefined) {
            throw new Error("Expected $scenarios");
        }
        const deleted = $scenarios.delete(scenarioId);
        if (!deleted) {
            throw new Error("scenarioId wasn't in scenarios");
        }
        return $scenarios;
    });
}

const _currentScenario: Readable<Scenario | undefined> = derived<
    [typeof model, typeof scenarios],
    Scenario | undefined
>([model, scenarios], ([$model, $scenarios], set) => {
    if ($scenarios === undefined) {
        set(undefined);
        return;
    }
    const current = $model.currentScenario;
    if (current === undefined) {
        set(undefined);
        return;
    }
    const scenario = $scenarios.get(current);
    if (scenario === undefined) {
        set(undefined);
    } else {
        set(scenario);
    }
});
export const currentScenario: Writable<Scenario | undefined> = {
    subscribe: _currentScenario.subscribe,
    set(newScenario: Scenario) {
        _scenarios.update(($scenarios) => {
            if ($scenarios === undefined) {
                throw new Error("Expected scenarios");
            }
            _model.update(($model) => {
                const { currentScenario } = $model;
                if (!currentScenario) {
                    throw new Error("Expected currentScenario");
                }
                _scenarios.set($scenarios.set(currentScenario, newScenario));
                return $model;
            });
            return $scenarios;
        });
    },
    update(updater: (v: Scenario | undefined) => Scenario) {
        _scenarios.update(($scenarios) => {
            if ($scenarios === undefined) {
                throw new Error("Expected scenarios");
            }
            _model.update(($model) => {
                const { currentScenario } = $model;
                if (!currentScenario) {
                    throw new Error("Expected currentScenario");
                }
                const scenario = $scenarios.get(currentScenario);
                if (scenario !== undefined) {
                    $scenarios.set(currentScenario, updater(scenario));
                }
                _scenarios.set($scenarios);
                return $model;
            });
            return $scenarios;
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
