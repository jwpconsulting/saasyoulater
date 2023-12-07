<script lang="ts">
    import { currentResults } from "$lib/stores/scenario";
    const currency = "$";
</script>

<h2>Results</h2>
<dl>
    <dt>EBIT positive</dt>
    <dd>At month <strong>{$currentResults.breakEven || "never"}</strong></dd>
    <dt>Cumulative EBIT positive</dt>
    <dd>
        At month <strong>{$currentResults.earningsBreakEven || "never"}</strong
        >
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
