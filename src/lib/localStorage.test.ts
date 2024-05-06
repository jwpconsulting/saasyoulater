import { it, describe, expect } from "vitest";
import { scenarioSerializer } from "./localStorage";

describe("scenarioSerializer", () => {
    const serialized = `{
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
}`;
    const serializedCompact =
        '{"1":{"cac":60,"comment":null,"customerGrowth":{"start":10,"growth":1,"churn":0.06},"fixedCost":100,"months":24,"name":null,"revenue":30,"revenueGrossMargin":0.5},"2":{"cac":45,"comment":"asd","customerGrowth":{"start":10,"growth":0.4,"churn":0.03},"fixedCost":100,"months":24,"name":"asd","revenue":30,"revenueGrossMargin":0.5}}';
    const deserialized = new Map([
        [
            1,
            {
                cac: 60,
                comment: undefined,
                customerGrowth: {
                    churnRate: 6,
                    growthRate: 100,
                    startValue: 10,
                },
                fixedCost: 100,
                months: 24,
                name: undefined,
                revenue: 30,
                revenueGrossMargin: 50,
            },
        ],
        [
            2,
            {
                cac: 45,
                comment: "asd",
                customerGrowth: {
                    churnRate: 3,
                    growthRate: 40,
                    startValue: 10,
                },
                fixedCost: 100,
                months: 24,
                name: "asd",
                revenue: 30,
                revenueGrossMargin: 50,
            },
        ],
    ]);
    describe("parse", () => {
        it("deserializes sample data well", () => {
            expect(scenarioSerializer.parse(serialized)).toStrictEqual(
                deserialized,
            );
        });
    });
    describe("stringify", () => {
        it("serializers back correctly", () => {
            expect(scenarioSerializer.stringify(deserialized)).toStrictEqual(
                serializedCompact,
            );
        });
        it("survives a round trip", () => {
            const back = scenarioSerializer.parse(
                scenarioSerializer.stringify(
                    scenarioSerializer.parse(
                        scenarioSerializer.stringify(deserialized),
                    ),
                ),
            );
            expect(back).toStrictEqual(deserialized);
        });
    });
});
