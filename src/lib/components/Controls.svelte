<script lang="ts">
    import NumberInput from "./form/NumberInput.svelte";
    const currency = "$";
</script>

<form>
    <h2>Controls</h2>
    <NumberInput min={1} max={100} label="Months" value={24} />
    <NumberInput
        min={1}
        max={100}
        label="Churn Rate"
        prefixUnit="%"
        value={3}
    />
    <NumberInput
        min={10}
        max={100}
        step={10}
        label="Customers at Start"
        value={10}
    />
    <NumberInput
        min={0}
        max={1000}
        step={10}
        label="C. Growth MoM"
        prefixUnit="%"
        value={40}
    />
    <NumberInput
        min={0}
        max={1000}
        step={10}
        label="Rev. per Customer"
        prefixUnit={currency}
        value={30}
    />
    <NumberInput
        min={0}
        max={100}
        step={5}
        label="Gross Margin"
        prefixUnit="%"
        value={50}
    />
    <NumberInput
        min={0}
        max={5000}
        step={5}
        label="CAC"
        prefixUnit={currency}
        value={50}
    />
    <NumberInput
        min={0}
        max={10000}
        step={100}
        label="Fixed Cost"
        prefixUnit={currency}
        value={100}
    />
</form>
