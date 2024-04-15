// Here's what the live Elm version stores:
// Value of "scenarios"
/*
{
  "1": {
    "months": 24,
    "revenue": 30,
    "customerGrowth": {
      "start": 10,
      "growth": 1,
      "churn": 0.06
    },
    "revenueGrossMargin": 0.5,
    "cac": 60,
    "fixedCost": 100,
    "comment": null,
    "name": null
  },
  "2": {
    "months": 24,
    "revenue": 30,
    "customerGrowth": {
      "start": 10,
      "growth": 0.4,
      "churn": 0.03
    },
    "revenueGrossMargin": 0.5,
    "cac": 45,
    "fixedCost": 100,
    "comment": "asd",
    "name": "asd"
  }
}
*/
// Value of "currency"
// "usd"

import type { Serializer } from "svelte-persisted-store";
import type { Scenario } from "./types";
import { z } from "zod";

const customerGrowth = z.object({
    startValue: z.number(),
    growthRate: z.number(),
    churnRate: z.number(),
});

const scenario = z.object({
    months: z.number(),
    revenue: z.number(),
    customerGrowth,
    revenueGrossMargin: z.number(),
    cac: z.number(),
    fixedCost: z.number(),
    name: z.optional(z.string()),
    comment: z.optional(z.string()),
});

const scenariosMap = z.map(z.number(), scenario);

export const scenarioSerializer: Serializer<Map<number, Scenario>> = {
    parse(text: string): Map<number, Scenario> {
        const raw: Record<string, unknown> = JSON.parse(text);
        const scenariosRaw: [number, unknown][] = Object.entries(raw).map(
            ([k, v]) => {
                return [parseInt(k, 10), v];
            },
        );
        return scenariosMap.parse(new Map(scenariosRaw));
    },
    stringify(o: Map<number, Scenario>): string {
        const record: Record<number, Scenario> = Object.fromEntries([...o]);
        return JSON.stringify(record);
    },
};
