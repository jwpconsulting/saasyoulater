<script lang="ts">
    import NumberInput from "./form/NumberInput.svelte";
    import {
        months,
        customerGrowth,
        revenue,
        revenueGrossMargin,
        cac,
        fixedCost,
    } from "$lib/stores/scenario";
    const currency = "$";
</script>

<form>
    <h2>Controls</h2>
    <NumberInput min={1} max={100} label="Months" bind:value={$months} />
    <NumberInput
        min={1}
        max={100}
        label="Churn Rate"
        prefixUnit="%"
        bind:value={$customerGrowth.churnRate}
    />
    <NumberInput
        min={10}
        max={100}
        step={10}
        label="Customers at Start"
        bind:value={$customerGrowth.startValue}
    />
    <NumberInput
        min={0}
        max={1000}
        step={10}
        label="C. Growth MoM"
        prefixUnit="%"
        bind:value={$customerGrowth.startValue}
    />
    <NumberInput
        min={0}
        max={1000}
        step={10}
        label="Rev. per Customer"
        prefixUnit={currency}
        bind:value={$revenue}
    />
    <NumberInput
        min={0}
        max={100}
        step={5}
        label="Gross Margin"
        prefixUnit="%"
        bind:value={$revenueGrossMargin}
    />
    <NumberInput
        min={0}
        max={5000}
        step={5}
        label="CAC"
        prefixUnit={currency}
        bind:value={$cac}
    />
    <NumberInput
        min={0}
        max={10000}
        step={100}
        label="Fixed Cost"
        prefixUnit={currency}
        bind:value={$fixedCost}
    />
</form>
