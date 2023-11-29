<script lang="ts">
    export let label: string;
    export let value: string | undefined = undefined;
    export let placeholder: string | undefined = undefined;
    // TODO add type=text to input
</script>

<div class="form-group">
    <label>{label}</label><input
        class="form-control"
        placeholder={placeholder ?? label}
        bind:value
    />
</div>
