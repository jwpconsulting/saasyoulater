<script lang="ts">
    import {
        chooseScenario,
        model,
        scenarios,
        newScenario,
    } from "$lib/stores/model";

    $: s = [...($scenarios ?? [])];
</script>

<ul class="flex flex-row gap-8 text-base list-none">
    {#each s as [number, { name }] (number)}
        <li class:active={$model.currentScenario === number}>
            <button on:click={() => chooseScenario(number)}
                >{name ?? `Scenario ${number}`}</button
            >
        </li>
    {/each}
    <li><button on:click={newScenario}>+ Add a Scenario</button></li>
</ul>
