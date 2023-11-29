<script lang="ts">
    // TODO: make array containing values below
    // TODO: Recreate table from these values

    import TableBody from "./numbers/TableBody.svelte";
    import TableHead from "./numbers/TableHead.svelte";
</script>

<h2>Numbers</h2>
<div class="table-responsive">
    <table class="table table-hover table-condensed">
        <TableHead />
        <TableBody />
    </table>
</div>
