<script>
    import {ethers} from 'ethers';
    import { create } from 'ipfs-http-client'; 
    /* or a string */
    // const added = await client.add('hello world')

    import { Network, Alchemy } from "alchemy-sdk";

    export let web3Props = { 
        provider: null, 
        signer: null, 
        account: null, 
        chainId: null, 
        contract: null 
    };

    const settings = {
    apiKey: "",
    network: Network.ETH_GOERLI,
    };

    const alchemy = new Alchemy(settings);

    const ownerAddr = account;
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

    const info = {
        "description": "", 
        "external_url": "", 
        "image": "", 
        "name": "",
        "attributes": [], 
    }

    const pinJSONToIPFS = async () => {
        const url = `https://api.pinata.cloud/pinning/pinJSONToIPFS`;
        info.image = base64Img
        const response = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                pinata_api_key: pinataApiKey,
                pinata_secret_api_key: pinataSecretApiKey
            },
            body: JSON.stringify(info)
        });
        var res = await response.json()
        hash = res.IpfsHash
        console.log(hash)
    }

    let base64Img, fileinput;

    const onFileSelected =(e)=>{
    let image = e.target.files[0];
            let reader = new FileReader();
            reader.readAsDataURL(image);
            reader.onload = e => {
                 base64Img = e.target.result
            };
    }


</script>

<div class="uploadandmint">
    <input style="display:none" type="file" accept=".jpg, .jpeg, .png" on:change={(e)=>onFileSelected(e)} bind:this={fileinput} >
    <div class="card-body items-center text-center">
      <h2 class="card-title">Upload an Image</h2>
      <p>Please use .jpg, .jpeg, and .png only</p>
      <div class="card-actions">
        {#if !base64Img}
        <button class="btn btn-primary" on:click={()=>{fileinput.click();}}>Upload</button>
        {:else}
        <button class="btn btn-primary" on:click={()=>{pinJSONToIPFS(info)}}>Save to IPFS</button>
        {/if}
    </div>
    </div>
    {#if hash}
        <a href="https://gateway.pinata.cloud/ipfs/{hash}" class="link">IPFS Gateway to CID</a>
    {/if}
</div>