<script lang="ts">
    import Button from "./form/Button.svelte";
    import Currency from "./form/Currency.svelte";
    import TextArea from "./form/TextArea.svelte";
    import TextInput from "./form/TextInput.svelte";
    import { currentScenario, deleteScenario, model } from "$lib/stores/model";
</script>

<h3>Options</h3>
{#if $currentScenario}
    <Currency />
    <TextInput label="Scenario Name" bind:value={$currentScenario.name} />
    <TextArea
        label="Comment"
        placeholder="Scenario Comment"
        bind:value={$currentScenario.comment}
    />
    {#if $model.currentScenario}
        <Button
            label="Delete Scenario"
            onClick={deleteScenario.bind(null, $model.currentScenario)}
        />
    {/if}
{:else}
    No current scenario available
{/if}
