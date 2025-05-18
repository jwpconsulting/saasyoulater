<script lang="ts">
    import Controls from "$lib/components/Controls.svelte";
    import Numbers from "$lib/components/Numbers.svelte";
    import Options from "$lib/components/Options.svelte";
    import Results from "$lib/components/Results.svelte";
</script>

<div class="w-full px-10 flex flex-row flex-wrap xl:grid gap-x-8 grid-cols-4">
    <div class="xl:order-1">
        <Controls />
    </div>
    <div class="xl:order-4">
        <Results />
        <Options />
    </div>
    <div class="max-w-full xl:order-2 col-span-2">
        <Numbers />
    </div>
</div>
