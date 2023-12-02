<script lang="ts">
    import Button from "./form/Button.svelte";
    import Currency from "./form/Currency.svelte";
    import TextArea from "./form/TextArea.svelte";
    import TextInput from "./form/TextInput.svelte";
    import { currentScenario } from "$lib/stores/scenario";
</script>

<h3>Options</h3>
<Currency />
<TextInput label="Scenario Name" bind:value={$currentScenario.name} />
<TextArea
    label="Comment"
    placeholder="Scenario Comment"
    bind:value={$currentScenario.comment}
/>
<Button label="Delete Scenario" />
