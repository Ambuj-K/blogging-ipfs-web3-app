<script>

    import { Network, Alchemy } from "alchemy-sdk";

    export let web3Props = { 
        provider: null, 
        signer: null, 
        account: null, 
        chainId: null, 
        contract: null 
    };

    $: blogs = []

    //get NFTS
    const settings = {
    apiKey: "",
    network: Network.ETH_GOERLI,
    };

    const alchemy = new Alchemy(settings);

    async function get_blog_nfts(){
        const ownerAddr = web3Props.account;
        const nftsForOwner = await alchemy.nft.getNftsForOwner(ownerAddr);

        for (const nft of nftsForOwner.ownedNfts) {
            const response = await alchemy.nft.getNftMetadata(
            nft.contract.address, nft.tokenId);
            if (response.rawMetadata.description == "Blog As NFT"){
                const blog_response = await fetch("https://api.ipfsbrowser.com/ipfs/get.php?hash="+response.rawMetadata.external_url.split("//")[1]);
                const data = await blog_response.json();
                blogs = [...blogs, [data["title"], data["text"]]];
            }
        }
    }
    get_blog_nfts()
</script>

<br/>
<br/>
{#if blogs.length!=0}
    <b>Your Blogs</b>    
    <div>
        {#each blogs as blog}
            <div>Title: {blog[0]}</div>
            <div>Text: {blog[1]}</div>
        {/each} 
    </div>
{/if}
<!-- <button class='bttn' on:click={get_blog_nfts}>Log NFTs</button> -->