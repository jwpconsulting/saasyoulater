<script lang="ts">
    import { currentResults } from "$lib/stores/model";
    const currency = "$";
</script>

{#if $currentResults}
    <h2>Results</h2>
    <dl>
        <dt>EBIT positive</dt>
        <dd>
            {#if $currentResults.breakEven}
                At month <strong>{$currentResults.breakEven}</strong>
            {:else}
                Never
            {/if}
        </dd>
        <dt>Cumulative EBIT positive</dt>
        <dd>
            {#if $currentResults.earningsBreakEven}
                At month <strong>{$currentResults.earningsBreakEven}</strong>
            {:else}
                Never
            {/if}
        </dd>
        <dt>Average Customer Life</dt>
        <dd>
            <strong>{$currentResults.averageLife}</strong> months
        </dd>
        <dt>Customer Lifetime Value</dt>
        <dd>
            <strong class="text-success">{$currentResults.cltv}</strong>
            {currency}
        </dd>
        <dt>LTV over CAC</dt>
        <dd><span class="text-success">{$currentResults.ltvcac}</span></dd>
        <dt>Minimum Cumulative EBIT</dt>
        <dd>
            <strong class="text-warning"
                >{$currentResults.minimumCumulativeEarnings}</strong
            >
            {currency}
        </dd>
    </dl>
{:else}
    Results not available
{/if}
