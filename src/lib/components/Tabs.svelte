<script lang="ts">
    import { chooseScenario, model, newScenario } from "$lib/stores/model";

    $: scenarios = [...$model.scenarios];
</script>

<ul class="nav nav-tabs">
    {#each scenarios as [number, { name }] (number)}
        <li class:active={$model.currentScenario === number}>
            <a href="#" on:click={() => chooseScenario(number)}
                >{name ?? `Scenario ${number}`}</a
            >
        </li>
    {/each}
    <li><a href="#" on:click={newScenario}>+ Add a Scenario</a></li>
</ul>
