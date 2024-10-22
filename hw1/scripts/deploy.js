

async function main() {
    const toDeploy = Object.fromEntries(await Promise.all(
        ["IrlaCoinERC20", "IrlaCoinERC721", "IrlaCoinERC1155"].map(async name => [name, await ethers.getContractFactory(name)])
    ));

    for (const [coinName, factory] of Object.entries(toDeploy)) {
        await deploy(coinName, factory);
    }
}

async function deploy(coinName, network) {
    const [deployer] = await ethers.getSigners();
    const factory = await ethers.getContractFactory(coinName);
    const deploy = await network.deploy(deployer.address);
    await deploy.waitForDeployment(); 

    console.log(`${coinName} was deployed`);
}

main()