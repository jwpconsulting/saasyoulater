<script lang="ts">
    import { model } from "$lib/stores/model";
    import { currencyDefinitions } from "$lib/types";

    export let label: string;
    export let min: number;
    export let max: number;
    export let step = 1;
    export let prefixUnit: "percentage" | "currency" | undefined = undefined;
    export let value: number | undefined = undefined;

    let uid = `number-input-${self.crypto.randomUUID()}`;

    $: currency = currencyDefinitions[$model.currency].shortName;
</script>

<label for={uid} class="flex w-full justify-between"
    >{label}
    {#if prefixUnit}
        <div>
            <span class="input-group-addon"
                >{#if prefixUnit == "percentage"}%{:else if prefixUnit == "currency"}{currency}{/if}</span
            >
            <input
                id={uid}
                type="number"
                class="text-right"
                bind:value
                {min}
                {max}
                {step}
            />
        </div>
    {:else}
        <input
            id={uid}
            type="number"
            class="text-right"
            bind:value
            {min}
            {max}
            {step}
        />
    {/if}
</label>
