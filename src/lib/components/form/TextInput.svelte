<script lang="ts">
    export let label: string;
    export let value: string | undefined = undefined;
    export let placeholder: string | undefined = undefined;
    let uid = `text-input-${self.crypto.randomUUID()}`;
</script>

<label for={uid}
    >{label}<input id={uid} placeholder={placeholder ?? label} bind:value />
</label>
