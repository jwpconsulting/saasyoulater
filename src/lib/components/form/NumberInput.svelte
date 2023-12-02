<script lang="ts">
    export let label: string;
    export let min: number;
    export let max: number;
    export let step = 1;
    export let prefixUnit: "percentage" | "currency" | undefined = undefined;
    export let value: number | undefined = undefined;

    const currency = "$";
</script>

<div class="form-group">
    <label class="control-label">{label}</label>
    {#if prefixUnit}
        <div class="input-group">
            <span class="input-group-addon"
                >{#if prefixUnit == "percentage"}%{:else if prefixUnit == "currency"}{currency}{/if}</span
            >
            <input
                type="number"
                class="form-control text-right"
                bind:value
                {min}
                {max}
                {step}
            />
        </div>
    {:else}
        <input
            type="number"
            class="form-control text-right"
            bind:value
            {min}
            {max}
            {step}
        />
    {/if}
</div>
