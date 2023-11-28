<script lang="ts">
    const ebitPositiveMonth = 7;
    const cumulativeEbitPositiveMonth = 10;
    const averageCustomerLifeMonths = 33;
    const customerLifetimeValue = 990;
    const ltvOverCac = 22;
    const minimimumCumulativeEbit = -345;
    const currency = "$";
</script>

<h2>Results</h2>
<dl>
    <dt>EBIT positive</dt>
    <dd>At month <strong>{ebitPositiveMonth}</strong></dd>
    <dt>Cumulative EBIT positive</dt>
    <dd>At month <strong>{cumulativeEbitPositiveMonth}</strong></dd>
    <dt>Average Customer Life</dt>
    <dd><strong>{averageCustomerLifeMonths}</strong> months</dd>
    <dt>Customer Lifetime Value</dt>
    <dd>
        <strong class="text-success">{customerLifetimeValue}</strong>
        {currency}
    </dd>
    <dt>LTV over CAC</dt>
    <dd><span class="text-success">{ltvOverCac}</span></dd>
    <dt>Minimum Cumulative EBIT</dt>
    <dd>
        <strong class="text-warning">{minimimumCumulativeEbit}</strong>
        {currency}
    </dd>
</dl>
