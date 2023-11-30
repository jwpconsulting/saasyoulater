<script lang="ts">
    import Button from "./form/Button.svelte";
    import Currency from "./form/Currency.svelte";
    import TextArea from "./form/TextArea.svelte";
    import TextInput from "./form/TextInput.svelte";
    import { name, comment } from "$lib/stores/scenario";
</script>

<h3>Options</h3>
<Currency />
<TextInput label="Scenario Name" bind:value={$name} />
<TextArea
    label="Comment"
    placeholder="Scenario Comment"
    bind:value={$comment}
/>
<Button label="Delete Scenario" />
