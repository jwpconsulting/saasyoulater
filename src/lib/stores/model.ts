import type { Model, ScenarioId, Currency } from "$lib/types";
import type { Writable, Readable } from "svelte/store";
import { derived, readonly, writable } from "svelte/store";
import type { Datum, Results, Scenario } from "$lib/types";
import * as math from "$lib/math";
import { scenarioSerializer } from "$lib/localStorage";

import { persisted } from "svelte-persisted-store";

function defaultModel(): Model {
    return {
        currentScenario: undefined,
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
        initialRevenue: 0,
        cac: 45,
        fixedCost: 100,
    };
};

const _model = writable<Model>(defaultModel());
export const model = readonly(_model);

const _scenarios = persisted<Map<number, Scenario>>("scenarios", new Map(), {
    serializer: scenarioSerializer,
});
export const scenarios = readonly(_scenarios);

export function setScenario(scenarioId: ScenarioId, scenario: Scenario) {
    _scenarios.update(($scenarios) => {
        if (!$scenarios.has(scenarioId)) {
            throw new Error("Scenario not found");
        }
        return $scenarios.set(scenarioId, scenario);
    });
}

export function updateScenario(
    scenarioId: ScenarioId,
    updater: (v: Scenario) => Scenario,
) {
    _scenarios.update(($scenarios) => {
        const scenario = $scenarios.get(scenarioId);
        if (scenario === undefined) {
            throw new Error("Scenario not found");
        }
        return $scenarios.set(scenarioId, updater(scenario));
    });
}

export function chooseScenario(scenarioId: ScenarioId) {
    _scenarios.update(($scenarios) => {
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
export function newScenario(): Scenario {
    const newScenario = defaultScenario();
    _scenarios.update(($scenarios) => {
        if (!$scenarios) {
            throw new Error("Expected $scenarios");
        }
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
    return newScenario;
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
        const deleted = $scenarios.delete(scenarioId);
        if (!deleted) {
            throw new Error("scenarioId wasn't in scenarios");
        }
        return $scenarios;
    });
}

const _currentScenario: Readable<Scenario> = derived<
    [typeof model, typeof scenarios],
    Scenario
>(
    [model, scenarios],
    ([$model, $scenarios], set) => {
        const current = $model.currentScenario;
        if (current === undefined) {
            if ($scenarios.size === 0) {
                const scenario = newScenario();
                set(scenario);
            } else {
                // Not very efficient, but getting .next().value from
                // iterator gives us any? why?
                const entry = [...$scenarios.entries()].at(0);
                if (!entry) {
                    throw new Error("Expected nextScenario");
                }
                const [id, scenario] = entry;
                chooseScenario(id);
                set(scenario);
            }
        } else {
            const scenario = $scenarios.get(current);
            if (scenario === undefined) {
                throw new Error("Expected scenario");
            } else {
                set(scenario);
            }
        }
    },
    defaultScenario(),
);
export const currentScenario: Writable<Scenario> = {
    subscribe: _currentScenario.subscribe,
    set(newScenario: Scenario) {
        _model.update(($model) => {
            const { currentScenario } = $model;
            if (!currentScenario) {
                throw new Error("Expected currentScenario");
            }
            setScenario(currentScenario, newScenario);
            return $model;
        });
    },
    update(updater: (v: Scenario) => Scenario) {
        _model.update(($model) => {
            const { currentScenario } = $model;
            if (!currentScenario) {
                throw new Error("Expected currentScenario");
            }
            updateScenario(currentScenario, updater);
            return $model;
        });
    },
};

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
