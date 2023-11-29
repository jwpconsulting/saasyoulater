<script lang="ts">
    export let label: string;
    export let value: string | undefined = undefined;
    export let placeholder: string | undefined = undefined;
    // TODO a11y
</script>

<div class="form-group">
    <label>{label}</label><textarea
        class="form-control"
        bind:value
        placeholder={placeholder ?? label}
    ></textarea>
</div>
