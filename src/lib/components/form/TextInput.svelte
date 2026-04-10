<script lang="ts">
    export let label: string;
    export let value: string | undefined = undefined;
    export let placeholder: string | undefined = undefined;
    let uid = `text-input-${self.crypto.randomUUID()}`;
</script>

<div class="form-group">
    <label for={uid}>{label}</label><input
        class="form-control"
        id={uid}
        placeholder={placeholder ?? label}
        bind:value
    />
</div>
