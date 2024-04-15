<script lang="ts">
    import {
        chooseScenario,
        model,
        scenarios,
        newScenario,
    } from "$lib/stores/model";

    $: s = [...($scenarios ?? [])];
</script>

<ul class="nav nav-tabs">
    {#each s as [number, { name }] (number)}
        <li class:active={$model.currentScenario === number}>
            <a href="#" on:click={() => chooseScenario(number)}
                >{name ?? `Scenario ${number}`}</a
            >
        </li>
    {/each}
    <li><a href="#" on:click={newScenario}>+ Add a Scenario</a></li>
</ul>
