<script lang="ts">
    import "$lib/app.css";
    import Header from "$lib/components/Header.svelte";
    import Footer from "$lib/components/Footer.svelte";
    import Help from "$lib/components/Help.svelte";
</script>

<svelte:head>
    <title>SaaS You Later</title>
</svelte:head>

<div class="container">
    <Header />
    <slot />
    <hr />
    <Help />
    <hr />
    <Footer />
</div>
