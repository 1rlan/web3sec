
async function main() {
    for (const coinName of ["IrlaCoinERC20", "IrlaCoinERC721", "IrlaCoinERC1155"]) {
        await deploy(coinName)
    }
}

async function deploy(coinName) {
    const [signer] = await ethers.getSigners();
    const factory = await ethers.getContractFactory(coinName);
    const deploy = await factory.deploy(signer.address);
    await deploy.waitForDeployment(); 

    console.log(`${coinName} was deployed`);
}

main()