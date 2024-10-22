
async function main() {
    coins = {
        "IrlaCoinERC20": "0x5fbdb2315678afecb367f032d93f642f64180aa3", 
        "IrlaCoinERC721": "0xe7f1725e7734ce288f8367e1bb143e90bb3f0512", 
        "IrlaCoinERC1155": "0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0"
    }

    for (const [coinName, contract] of Object.entries(coins)) {
        await checkStorage(coinName, contract)
    }
}

async function checkStorage(coinName, contractAddress) {
    const factory = await ethers.getContractFactory(coinName);
    const contract = await factory.attach(contractAddress);

    console.log(`${coinName} Data:`)
    for (let i = 0; i < 10; i++) {
        const storageValue = await ethers.provider.getStorage(contract, i);
        console.log(`Storage at slot ${i}: ${storageValue}`)
    }
}

main();