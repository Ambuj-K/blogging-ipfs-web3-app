<script>
    import WalletConnect from "../lib/WalletConnect.svelte";
    import Medium from "../lib/Medium.svelte"
    import contractAbi from "../contracts/Medium.json";
    const contractAddr =  "";
    export let web3Props = {
        provider : null,
        signer : null,
        account : null,
        chainId : null
    };
</script>

<div class="OUTER">
<h1>Play with Your Pet Emoji</h1>
</div>
{#if !web3Props.account}
<WalletConnect bind:web3Props {contractAddr} {contractAbi} />
{:else}
<Medium bind:web3Props />
{/if}

<style>
    .OUTER {
        border-radius: 15px;
        padding: 20px;
        overflow: hidden;
        position: relative;
        background-color: rgb(214, 226, 43);
        box-shadow: 1px 4px 1px rgba(0,0,0,0.3);
    }
</style>