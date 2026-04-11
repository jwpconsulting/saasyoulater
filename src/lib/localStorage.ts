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

export const scenarioSerializer: Serializer<Map<number, Scenario>> = {
    parse(text: string): Map<number, Scenario> {
        const raw = JSON.parse(text);
        const entries: [number, Scenario][] = Object.entries(raw).map(
            ([k, v]: [string, any]) => {
                return [
                    parseInt(k, 10),
                    {
                        months: v.months,
                        revenue: v.revenue,
                        customerGrowth: {
                            startValue: v.customerGrowth.start,
                            growthRate: v.customerGrowth.growth * 100,
                            churnRate: v.customerGrowth.churn * 100,
                        },
                        revenueGrossMargin: v.revenueGrossMargin * 100,
                        cac: v.cac,
                        fixedCost: v.fixedCost,
                        name: v.name ?? undefined,
                        comment: v.comment ?? undefined,
                    },
                ];
            },
        );
        return new Map(entries);
    },
    stringify(o: Map<number, Scenario>): string {
        const records: [string, unknown][] = [...o].map(
            ([k, v]: [number, Scenario]) => [
                k.toString(),
                {
                    ...v,
                    customerGrowth: {
                        start: v.customerGrowth.startValue,
                        growth: v.customerGrowth.growthRate / 100,
                        churn: v.customerGrowth.churnRate / 100,
                    },
                    revenueGrossMargin: v.revenueGrossMargin / 100,
                    name: v.name ?? null,
                    comment: v.comment ?? null,
                },
            ],
        );
        return JSON.stringify(Object.fromEntries(records));
    },
};
