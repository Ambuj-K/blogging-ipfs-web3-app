<script>
    import WalletConnect from "../lib/WalletConnect.svelte";
    import Medium from "../lib/Medium.svelte"
    import MyBlogs from "../lib/MyBlogs.svelte"
    import contractAbi from "../contracts/Medium.json";
    const contractAddr =  "0x007858d81f652DE257C81ca21B176E60B69d5f4b";
    export let web3Props = {
        provider : null,
        signer : null,
        account : null,
        chainId : null
    };
</script>

<div class="OUTER">
<h1>Medium Blogs</h1>
</div>
{#if !web3Props.account}
<WalletConnect bind:web3Props {contractAddr} {contractAbi} />
{:else}
<br/>
<Medium bind:web3Props />
<MyBlogs bind:web3Props />
{/if}

<style>
    .OUTER {
        border-radius: 15px;
        padding: 20px;
        overflow: hidden;
        position: relative;
        background-color: rgb(231, 146, 20);
        box-shadow: 1px 4px 1px rgba(0,0,0,0.3);
    }
</style>