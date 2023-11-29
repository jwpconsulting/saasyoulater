<script lang="ts">
    import Currency from "./form/Currency.svelte";
    import TextInput from "./form/TextInput.svelte";
</script>

<h3>Options</h3>
<Currency />
<TextInput label="Scenario Name" />
<div class="form-group">
    <label>Comment</label><textarea
        class="form-control"
        placeholder="Scenario Comment"
    ></textarea>
</div>
<a href="#" class="btn btn-danger btn-xs btn-block">Delete Scenario</a>
