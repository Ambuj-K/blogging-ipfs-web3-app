<script>
    import {ethers} from 'ethers';
    export let web3Props = { 
        provider: null, 
        signer: null, 
        account: null, 
        chainId: null, 
        contract: null 
    };

    $: title = ''
    $: text = ''
    var hash = ''

    const json_uri_info = {
        "description": "Blog As NFT", 
        "external_url": "", 
        "image": "ipfs://QmV7erPeurh4RytqBtN8pd5UzsS5msdw9japDeejiMNndz/Astronaut.jpg"
    }

    const json_blog_info = {
        "name": "Blog Post",
        "title": "", 
        "text": ""
    }

    const pinJSONToIPFS = async (info) => {
        const url = `https://api.pinata.cloud/pinning/pinJSONToIPFS`;
        const response = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                pinata_secret_api_key:'',
                pinata_api_key: ''
            },
            body: JSON.stringify(info)
        });
        var res = await response.json()
        hash = res.IpfsHash
        console.log(hash)
    }

    // let base64Img, fileinput;

    // const onFileSelected =(e)=>{
    // let image = e.target.files[0];
    //         let reader = new FileReader();
    //         reader.readAsDataURL(image);
    //         reader.onload = e => {
    //              base64Img = e.target.result
    //         };
    // }

    const uploadFile = async() => {
        json_blog_info.title = title;
        json_blog_info.text = text;
        await pinJSONToIPFS(json_blog_info);
        json_uri_info.external_url = "ipfs://"+hash
        await pinJSONToIPFS(json_uri_info);
        console.log("ipfs://"+hash)
        await web3Props.contract.safeMint(
            web3Props.account,
            "ipfs://"+hash, 
            {
                value: ethers.utils.parseEther("0.02"),
            });
    }


</script>

<div class="uploadandmint">
    <!-- <input style="display:none" type="file" accept=".jpg, .jpeg, .png" on:change={(e)=>onFileSelected(e)} bind:this={fileinput} >
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
    </div> -->
    <div class="accordion">
          <div className="writeFormGroup">
          <input
              className="writeInput"
              placeholder="Title"
              type="text"
              autoFocus={true}
              bind:value={title}
              size="50"
              height="20"
            />
          </div>
          <div className="writeFormGroup">
          <textarea
              className="writeInput writeText"
              placeholder="Tell your story..."
              autoFocus={true}
              bind:value={text}
              rows="20" 
              cols="170"
            />
          </div>
          <button className="writeSubmit" type="reset" on:click={uploadFile}>
            Publish
          </button>
    </div>
    {#if hash}
        <a href="https://gateway.pinata.cloud/ipfs/{hash}" class="link">IPFS Gateway to CID</a>
    {/if}
</div>

<style>
.accordion {
  background-color: white;
  color: black;
  border-radius: 0.5rem;
  overflow: hidden;
  width: 100%;
  display: flex;
  flex-direction: column;
}

.writeForm {
    position: relative;
    margin-top: 30px;
  }
  
  .writeFormGroup {
    width: 250px;
    height: 250px;
    margin-left: 150px;
    display: flex;
    align-items: center;
  }
  
  .writeIcon {
    width: 25px;
    height: 25px;
    font-size: 20px;
    border: 1px solid;
    border-radius: 50%;
    color: rgb(129, 125, 125);
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
  }
  
  .writeInput {
    width: 225px;
    height: 225px;
    font-size: 30px;
    border: none;
    padding: 200px;
    width: 700vw;
  }
  
  .writeInput::placeholder {
    color: rgb(189, 185, 185);
    font-weight: 400;
  }
  
  .writeInput:focus {
    outline-style: none;
  }
  
  .writeText {
    width: 700vw;
    height: 1000vh;
    font-family: inherit;
    font-size: 20px;
  }
  
  .writeSubmit {
    position: absolute;
    top: 20px;
    right: 50px;
    color: white;
    background-color: teal;
    padding: 10px;
    border: none;
    border-radius: 10px;
    font-size: 16px;
    cursor: pointer;
    display: flex;
    align-items: center;
    height: 50px
  }
</style>