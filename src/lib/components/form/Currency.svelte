<script lang="ts">
    import type { Currency } from "$lib/types";
    import { currencyDefinitions } from "$lib/types";
    import { setCurrency } from "$lib/stores/model";

    function select(
        event: Event & { currentTarget: EventTarget & HTMLSelectElement },
    ) {
        const value: Currency = event.currentTarget.value as Currency;
        console.log(value);
        setCurrency(value);
    }

    $: options = Object.entries(currencyDefinitions).map(
        ([code, { longName }]) => [code, longName],
    );
</script>

<label for="currency"
    >Currency
    <select id="currency" on:change={select} class="form-control">
        {#each options as [value, name]}
            <option {value}>{name}</option>
        {/each}
    </select>
</label>
