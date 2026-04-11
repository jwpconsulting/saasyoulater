<script lang="ts">
    export let label: string;
    // XXX this is not a button, it's an anchor. Not very accessible.
    // Obviously this only supports red as a color right now
    export let onClick: () => void;
</script>

<button on:click={onClick}>{label}</button>
