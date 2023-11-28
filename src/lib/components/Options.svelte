<script lang="ts">
    import Currency from "./form/Currency.svelte";
</script>

<h3>Options</h3>
<Currency />
<div class="form-group">
    <label>Scenario Name</label><input
        class="form-control"
        placeholder="Scenario Name"
    />
</div>
<div class="form-group">
    <label>Comment</label><textarea
        class="form-control"
        placeholder="Scenario Comment"
    ></textarea>
</div>
<a href="#" class="btn btn-danger btn-xs btn-block">Delete Scenario</a>
