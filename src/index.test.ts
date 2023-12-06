import type { Scenario } from "$lib/types";
import { describe, it, expect, test } from "vitest";
import * as math from "$lib/math";
describe("sum test", () => {
    it("adds 1 + 2 to equal 3", () => {
        expect(1 + 2).toBe(3);
    });
});

// emptyScenario : Model.Scenario
const emptyScenario: Scenario = {
    //     { months = 12
    months: 12,
    //     , revenue = 30
    revenue: 30,
    //     , customerGrowth =
    customerGrowth: {
        //         { startValue = 0
        startValue: 0,
        //         , growthRate = 1
        growthRate: 100,
        //         , churnRate = 0.5
        churnRate: 50,
    },
    //         }
    //     , revenueGrossMargin = 0.75
    revenueGrossMargin: 75,
    //     , cac = 50
    cac: 50,
    //     , fixedCost = 0
    fixedCost: 0,
    //     , comment = Nothing
    comment: undefined,
    //     , name = Nothing
    name: undefined,
    //     }
};
//
//
// constantScenario : Model.Scenario
const constantScenario: Scenario = {
    //     { months = 12
    months: 12,
    //     , revenue = 30
    revenue: 30,
    //     , customerGrowth =
    customerGrowth: {
        //         { startValue = 10
        startValue: 10,
        //         , growthRate = 0
        growthRate: 0,
        //         , churnRate = 0
        churnRate: 0,
        //         }
    },
    //     , revenueGrossMargin = 1
    revenueGrossMargin: 100,
    //     , cac = 50
    cac: 50,
    //     , fixedCost = 100
    fixedCost: 100,
    //     , comment = Nothing
    comment: undefined,
    //     , name = Nothing
    name: undefined,
    //     }
};
//
//
// constantLossyScenario : Model.Scenario
const constantLossyScenario: Scenario = {
    //     { months = 12
    months: 12,
    //     , revenue = 30
    revenue: 30,
    //     , customerGrowth =
    customerGrowth: {
        //         { startValue = 10
        startValue: 10,
        //         , growthRate = 1
        growthRate: 100,
        //         , churnRate = 1
        churnRate: 100,
        //         }
    },
    //     , revenueGrossMargin = 1
    revenueGrossMargin: 100,
    //     , cac = 50
    cac: 50,
    //     , fixedCost = 100
    fixedCost: 100,
    //     , comment = Nothing
    comment: undefined,
    //     , name = Nothing
    name: undefined,
    //     }
};
//
//
//
//
// math : Test
// math =
// describe "Math"
describe("Math", () => {
    // [ describe "effectiveGrowth"
    describe("effectiveGrowth", () => {
        // [ test "1.5 effectiveGrowth for emptyScenario" <|
        test("1.5 effectiveGrowth for emptyScenario", () => {
            // \() ->
            // Expect.equal 1.5 <| Math.effectiveGrowth emptyScenario.customerGrowth
            expect(math.effectiveGrowth(emptyScenario.customerGrowth)).toBe(
                1.5,
            );
        });
        // , test "1 effectiveGrowth for constantScenario" <|
        test("1 effectiveGrowth for constantScenario", () => {
            // \() ->
            // Expect.equal 1 <| Math.effectiveGrowth constantScenario.customerGrowth
            expect(math.effectiveGrowth(constantScenario.customerGrowth)).toBe(
                1,
            );
            // ]
        });
    });
    // , describe "customerAcquisitionCost"
    describe("customerAcquisitionCost", () => {
        // [ test "0 for constantScenario" <|
        test("0 for constantScenario", () => {
            // \() ->
            // Expect.equal 0 <| Math.customerAcquisitionCost constantScenario constantScenario.months
            expect(
                math.customerAcquisitionCost(
                    constantScenario,
                    constantScenario.months,
                ),
            ).toBe(0);
        });
        // , test "10 * 50 for constantLossyScenario" <|
        test("10 * 50 for constantLossyScenario", () => {
            // \() ->
            // Expect.equal -500 <| Math.customerAcquisitionCost constantLossyScenario constantLossyScenario.months
            expect(
                math.customerAcquisitionCost(
                    constantLossyScenario,
                    constantLossyScenario.months,
                ),
                // XXX -500 is incorrect. Cost is a positive value
            ).toBe(500);
            // ]
        });
    });
    // , describe "earnings"
    describe("earnings", () => {
        // [ describe "emptyScenario"
        describe("emptyScenario", () => {
            // [ test "125 earnings at start" <|
            test("125 earnings at start", () => {
                // \() ->
                // Expect.equal 0 <|
                // Math.earnings emptyScenario Math.firstMonth
                expect(math.earnings(emptyScenario, math.firstMonth)).toBe(0);
            });
            // , test "125 earnings at end" <|
            test("125 earnings at end", () => {
                // \() ->
                // Expect.equal 0 <|
                // Math.earnings emptyScenario emptyScenario.months
                expect(
                    math.earnings(emptyScenario, emptyScenario.months),
                ).toBe(0);
                // ]
            });
            // ]
        });
        // , describe "constantScenario"
        describe("constantScenario", () => {
            // [ test "200 earnings at start" <|
            test("200 earnings at start", () => {
                // \() ->
                // Expect.equal 200 <|
                // Math.earnings constantScenario Math.firstMonth
                expect(math.earnings(constantScenario, math.firstMonth)).toBe(
                    200,
                );
            });
            // , test "200 earnings at end" <|
            test("200 earnings at end", () => {
                // \() ->
                // Expect.equal 200 <|
                // Math.earnings constantScenario constantScenario.months
                expect(
                    math.earnings(constantScenario, constantScenario.months),
                ).toBe(200);
            });
            // ]
        });
        // ]
    });
    // , describe "cumulativeEarnings"
    describe("cumulativeEarnings", () => {
        // [ describe "constantScenario"
        describe("constantScenario", () => {
            // [ test "200 revenue at start" <|
            test("200 revenue at start", () => {
                // \() ->
                // Expect.equal 200 <|
                // Math.cumulativeEarnings constantScenario Math.firstMonth
                expect(
                    math.cumulativeEarnings(constantScenario, math.firstMonth),
                ).toBe(200);
            });
            // , test "200 * 2 revenue at month 2" <|
            test("200 * 2 revenue at month 2", () => {
                // \() ->
                // Expect.equal (200 * 2) <|
                // Math.cumulativeEarnings constantScenario <|
                // Math.firstMonth
                // + 1
                expect(
                    math.cumulativeEarnings(
                        constantScenario,
                        math.firstMonth + 1,
                    ),
                ).toBe(200 * 2);
            });
            // , test "200 * months revenue at end" <|
            test("200 * months revenue at end", () => {
                // \() ->
                // Expect.equal (200 * constantScenario.months) <|
                // Math.cumulativeEarnings constantScenario constantScenario.months
                expect(
                    math.cumulativeEarnings(
                        constantScenario,
                        constantScenario.months,
                    ),
                ).toBe(200 * constantScenario.months);
                // ]
            });
        });
        // ]
    });
    // , describe "revenue"
    describe("revenue", () => {
        // [ describe "constantScenario"
        describe("constantScenario", () => {
            // [ test "300 revenue at start" <|
            test("300 revenue at start", () => {
                // \() ->
                // Expect.equal 300 <|
                // Math.revenue constantScenario Math.firstMonth
                expect(math.revenue(constantScenario, math.firstMonth)).toBe(
                    300,
                );
            });
            // , test "300 revenue at month 1" <|
            test("300 revenue at month 1", () => {
                // \() ->
                // Expect.equal 300 <|
                // Math.revenue constantScenario 1
                expect(math.revenue(constantScenario, 1)).toBe(300);
            });
            // , test "300 revenue at end" <|
            test("300 revenue at end", () => {
                // \() ->
                // Expect.equal 300 <|
                // Math.revenue constantScenario constantScenario.months
                expect(
                    math.revenue(constantScenario, constantScenario.months),
                ).toBe(300);
                // ]
            });
        });
        // ]
    });
    // , describe "customers"
    describe("customers", () => {
        // [ describe "constantScenario"
        describe("constantScenario", () => {
            // [ test "10 customers at start" <|
            test("10 customers at start", () => {
                // \() ->
                // Expect.equal 10 <|
                // Math.customers constantScenario.customerGrowth Math.firstMonth
                expect(
                    math.customers(
                        constantScenario.customerGrowth,
                        math.firstMonth,
                    ),
                ).toBe(10);
            });
            // , test "10 customers at end" <|
            test("10 customers at end", () => {
                // \() ->
                // Expect.equal 10 <|
                // Math.customers constantScenario.customerGrowth
                // constantScenario.months
                expect(
                    math.customers(
                        constantScenario.customerGrowth,
                        constantScenario.months,
                    ),
                ).toBe(10);
                // ]
            });
        });
        // , describe "emptyScenario"
        describe("emptyScenario", () => {
            // [ test "0 customers at start" <|
            test("0 customers at start", () => {
                // \() ->
                // Expect.equal 0 <|
                // Math.customers emptyScenario.customerGrowth Math.firstMonth
                expect(
                    math.customers(
                        emptyScenario.customerGrowth,
                        math.firstMonth,
                    ),
                ).toBe(0);
            });
            // , test "0 customers at end" <|
            test("0 customers at end", () => {
                // \() ->
                // Expect.equal 0 <|
                // Math.customers emptyScenario.customerGrowth emptyScenario.months
                expect(
                    math.customers(
                        emptyScenario.customerGrowth,
                        emptyScenario.months,
                    ),
                ).toBe(0);
                // ]
            });
        });
        // ]
    });
    // ]
    describe("linspace", () => {
        test("it gives correct values", () => {
            expect(math.linspace(0, 1, 0)).toStrictEqual([]);
            expect(math.linspace(0, 1, 1)).toStrictEqual([1]);
            expect(math.linspace(10, 50, 5)).toStrictEqual([
                10, 20, 30, 40, 50,
            ]);
        });
    });
    describe("months", () => {
        test("it gives correct values", () => {
            expect(math.months(0)).toStrictEqual([]);
            expect(math.months(1)).toStrictEqual([1]);
            expect(math.months(12)).toStrictEqual([
                1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
            ]);
            expect(math.months(24)).toStrictEqual([
                1, 3, 5, 7, 9, 11, 14, 16, 18, 20, 22, 24,
            ]);
        });
    });
});

// all : Test
// all : Test
// all =
// all =
// describe "All tests" [ math, TestCurrency.currency ]
// describe "All tests" [ math, TestCurrency.currency ]
