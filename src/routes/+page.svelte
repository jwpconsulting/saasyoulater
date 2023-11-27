<script lang="ts">
    import Controls from "$lib/components/Controls.svelte";
    import Footer from "$lib/components/Footer.svelte";
    import Header from "$lib/components/Header.svelte";
    import Help from "$lib/components/Help.svelte";
    import Numbers from "$lib/components/Numbers.svelte";
    import Options from "$lib/components/Options.svelte";
    import Results from "$lib/components/Results.svelte";
</script>

<Header />
<div class="row">
    <div class="col-xs-6 col-md-2">
        <Controls />
    </div>
    <div class="col-xs-6 col-md-3 col-md-push-7">
        <Results />
        <Options />
    </div>
    <div class="col-xs-12 col-md-7 col-md-pull-3"><Numbers /></div>
</div>
<hr />
<Help />
<hr />
<Footer />
