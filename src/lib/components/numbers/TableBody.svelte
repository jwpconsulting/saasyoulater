<script lang="ts">
    // TODO the coloring is not necessarily correct. Refer to View.elm
    // TODO color cum. ebit
    const currency = "$";
    const data = [
        {
            month: 1,
            customers: 10,
            revenue: 300,
            grossMargin: 150,
            expenses: 235,
            ebit: -85,
            cumulativeEbit: -85,
        },
        {
            month: 3,
            customers: 19,
            revenue: 570,
            grossMargin: 285,
            expenses: 370,
            ebit: -85,
            cumulativeEbit: -240,
        },
        {
            month: 5,
            customers: 35,
            revenue: 1050,
            grossMargin: 525,
            expenses: 550,
            ebit: -25,
            cumulativeEbit: -335,
        },
        {
            month: 7,
            customers: 66,
            revenue: 1980,
            grossMargin: 990,
            expenses: 955,
            ebit: 35,
            cumulativeEbit: -310,
        },
        {
            month: 9,
            customers: 124,
            revenue: 3720,
            grossMargin: 1860,
            expenses: 1720,
            ebit: 140,
            cumulativeEbit: -75,
        },
        {
            month: 11,
            customers: 233,
            revenue: 6990,
            grossMargin: 3495,
            expenses: 3160,
            ebit: 335,
            cumulativeEbit: 460,
        },
        {
            month: 14,
            customers: 599,
            revenue: 17970,
            grossMargin: 8985,
            expenses: 7975,
            ebit: 1010,
            cumulativeEbit: 2665,
        },
        {
            month: 16,
            customers: 1124,
            revenue: 33720,
            grossMargin: 16860,
            expenses: 14860,
            ebit: 2000,
            cumulativeEbit: 6080,
        },
        {
            month: 18,
            customers: 2110,
            revenue: 63300,
            grossMargin: 31650,
            expenses: 27820,
            ebit: 3830,
            cumulativeEbit: 12660,
        },
        {
            month: 20,
            customers: 3960,
            revenue: 118800,
            grossMargin: 59400,
            expenses: 52120,
            ebit: 7280,
            cumulativeEbit: 25210,
        },
        {
            month: 22,
            customers: 7432,
            revenue: 222960,
            grossMargin: 111480,
            expenses: 97750,
            ebit: 13730,
            cumulativeEbit: 48935,
        },
        {
            month: 24,
            customers: 13950,
            revenue: 418500,
            grossMargin: 209250,
            expenses: 183385,
            ebit: 25865,
            cumulativeEbit: 93645,
        },
    ];
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
