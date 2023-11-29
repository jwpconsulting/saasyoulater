<script lang="ts">
    import Button from "./form/Button.svelte";
    import Currency from "./form/Currency.svelte";
    import TextArea from "./form/TextArea.svelte";
    import TextInput from "./form/TextInput.svelte";
</script>

<h3>Options</h3>
<Currency />
<TextInput label="Scenario Name" />
<TextArea label="Comment" placeholder="Scenario Comment" />
<Button label="Delete Scenario" />
