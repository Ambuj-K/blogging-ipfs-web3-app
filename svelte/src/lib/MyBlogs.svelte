<script>

    import { Network, Alchemy } from "alchemy-sdk";

    export let web3Props = { 
        provider: null, 
        signer: null, 
        account: null, 
        chainId: null, 
        contract: null 
    };

    //get NFTS
    const settings = {
    apiKey: "xXljex9ya0BwLoQFs30xWLHRlmWkrX6I",
    network: Network.ETH_GOERLI,
    };

    const alchemy = new Alchemy(settings);

    async function log_nfts(){
        const ownerAddr = web3Props.account;
        console.log("fetching NFTs for address:", ownerAddr);
        console.log("...");

        const nftsForOwner = await alchemy.nft.getNftsForOwner(ownerAddr);
        console.log("number of NFTs found:", nftsForOwner.totalCount);
        console.log("...");

        for (const nft of nftsForOwner.ownedNfts) {
        console.log("===");
        console.log("contract address:", nft.contract.address);
        console.log("token ID:", nft.tokenId);
        }
        console.log("===");
    }
</script>

<br/>
<br/>
<button class='bttn' on:click={log_nfts}>Log NFTs</button>