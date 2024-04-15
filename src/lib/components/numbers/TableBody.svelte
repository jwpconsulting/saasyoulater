<script lang="ts">
    import { currentResults } from "$lib/stores/model";

    // TODO the coloring is not necessarily correct. Refer to View.elm
    // TODO color cum. ebit
    const currency = "$";
</script>

{#if $currentResults}
    <tbody>
        {#each $currentResults.data as row}
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
{:else}
    <p>Results not available</p>
{/if}
