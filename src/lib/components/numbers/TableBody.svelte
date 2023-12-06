<script lang="ts">
    import type { Month } from "$lib/types";
    import { currentScenario as scenario } from "$lib/stores/scenario";
    import * as math from "$lib/math";

    // TODO the coloring is not necessarily correct. Refer to View.elm
    // TODO color cum. ebit
    const currency = "$";
    interface Datum {
        month: Month;
        customers: number;
        revenue: number;
        grossMargin: number;
        expenses: number;
        ebit: number;
        cumulativeEbit: number;
    }
    let data: Datum[] = [];
    $: {
        const months = math.months($scenario.months);
        console.log(months);
        data = months.map((month: number) => {
            return {
                month,
                customers: math.customers($scenario.customerGrowth, month),
                revenue: math.revenue($scenario, month),
                grossMargin: math.grossMargin($scenario, month),
                expenses: math.expenses($scenario, month),
                ebit: math.earnings($scenario, month),
                cumulativeEbit: math.cumulativeEarnings($scenario, month),
            };
        });
    }
</script>

<tbody>
    {#each data as row}
        <tr
            class:warning={row.cumulativeEbit < 0}
            class:success={row.cumulativeEbit >= 0}
        >
            <td class="text-right">{row.month}</td>
            <td class="text-right">{row.customers}</td>
            <td class="text-right">
                <strong class:text-success={row.revenue >= 0}>
                    {row.revenue}
                </strong>
                {currency}
            </td>
            <td class="text-right">
                <strong class:text-success={row.grossMargin >= 0}>
                    {row.grossMargin}
                </strong>
                {currency}
            </td>
            <td class="text-right">
                <strong class="text-success">{row.expenses}</strong>
                {currency}
            </td>
            <td class="text-right">
                <strong
                    class:text-success={row.ebit >= 0}
                    class:text-warning={row.ebit < 0}
                >
                    {row.ebit}
                </strong>
                {currency}
            </td>
            <td class="text-right">
                <strong
                    class:text-success={row.cumulativeEbit >= 0}
                    class:text-warning={row.cumulativeEbit < 0}
                >
                    {row.cumulativeEbit}
                </strong>
                {currency}
            </td>
        </tr>
    {/each}
</tbody>
