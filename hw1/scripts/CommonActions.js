
async function main() {
    // await erc20actions();
    await erc721actions();
}

async function erc20actions() {
    console.log("ERC20 Actions:")

    const factory = await ethers.getContractFactory("IrlaCoinERC20");
    const [sender, recipient] = await ethers.getSigners();
    const contractAddress = "0x5fbdb2315678afecb367f032d93f642f64180aa3";
    const contract = await factory.attach(contractAddress);

    console.log(`Inital balance of sender: ${await contract.balanceOf(sender.address)}`);
    console.log(`Inital balance of recipient: ${await contract.balanceOf(recipient.address)}`);

    console.log("Minting...")
    await contract.mint(sender.address, 1337);

    console.log("Buying...")
    await contract.buy(sender.address, {value: 7331})

    console.log("Transfering...")
    await contract.transfer(recipient.address, 228);

    console.log("Transfering from...")
    await contract.approve(recipient.address, 322);
    await contract.connect(recipient).transferFrom(sender.address, recipient.address, 322);

    newOwne20rBalance = await contract.balanceOf(sender.address);
    balanceNewOther = await contract.balanceOf(recipient.address);

    console.log(`Final balance of sender: ${await contract.balanceOf(sender.address)}`);
    console.log(`Final balance of recipient: ${await contract.balanceOf(recipient.address)}`);
}

async function erc721actions() {
    console.log("\nERC721 Actions:")
    
    const token = await hre.ethers.getContractFactory("IrlaCoinERC721");
    const [sender, recipient] = await ethers.getSigners();
    const contractAddress = sender.address;
    const contract = await token.attach(contractAddress);

    console.log("Safe minting...")
    await contract.safeMint(recipient.address, 1337);

    console.log("Safe transfering...")
    await contract.approve(recipient.address, 322);
    await contract.connect(recipient).safeTransferFrom(sender.address, recipient.address, 322);
}
  
main()