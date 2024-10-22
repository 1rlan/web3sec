
async function main() {
    const factory = await ethers.getContractFactory("IrlaCoinERC20");
    const [signer] = await ethers.getSigners();
    const contract = await factory.attach(signer.address);

    const balance = await ethers.provider.getStorage(contract, 0);
    console.log(`Balance of ${signer.address} is ${balance}`);
}

main()
