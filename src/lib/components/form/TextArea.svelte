<script lang="ts">
    export let label: string;
    export let value: string | undefined = undefined;
    export let placeholder: string | undefined = undefined;
    let uid = `text-area-${self.crypto.randomUUID()}`;
</script>

<div class="form-group">
    <label for={uid}>{label}</label><textarea
        id={uid}
        class="form-control"
        bind:value
        placeholder={placeholder ?? label}
    ></textarea>
</div>
