<script lang="ts">
    import NumberInput from "./form/NumberInput.svelte";
    import { currentScenario } from "$lib/stores/scenario";
</script>

<form>
    <h2>Controls</h2>
    <NumberInput
        min={1}
        max={100}
        label="Months"
        bind:value={$currentScenario.months}
    />
    <NumberInput
        min={1}
        max={100}
        label="Churn Rate"
        prefixUnit="percentage"
        bind:value={$currentScenario.customerGrowth.churnRate}
    />
    <NumberInput
        min={10}
        max={100}
        step={10}
        label="Customers at Start"
        bind:value={$currentScenario.customerGrowth.startValue}
    />
    <NumberInput
        min={0}
        max={1000}
        step={10}
        label="C. Growth MoM"
        prefixUnit="percentage"
        bind:value={$currentScenario.customerGrowth.growthRate}
    />
    <NumberInput
        min={0}
        max={1000}
        step={10}
        label="Rev. per Customer"
        prefixUnit="currency"
        bind:value={$currentScenario.revenue}
    />
    <NumberInput
        min={0}
        max={100}
        step={5}
        label="Gross Margin"
        prefixUnit="percentage"
        bind:value={$currentScenario.revenueGrossMargin}
    />
    <NumberInput
        min={0}
        max={5000}
        step={5}
        label="CAC"
        prefixUnit="currency"
        bind:value={$currentScenario.cac}
    />
    <NumberInput
        min={0}
        max={10000}
        step={100}
        label="Fixed Cost"
        prefixUnit="currency"
        bind:value={$currentScenario.fixedCost}
    />
</form>
