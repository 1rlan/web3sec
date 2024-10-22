
async function main() {
    const factory = await ethers.getContractFactory("IrlaCoinERC20");
        
    const contractAddress = "0x5fbdb2315678afecb367f032d93f642f64180aa3";
    const contract = await factory.attach(contractAddress);

    console.log(await contract.queryFilter("Transfer"))
}

main();