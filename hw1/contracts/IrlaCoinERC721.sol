// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract IrlaCoinERC721 is ERC721, Ownable {
    uint256 private _currentTokenId = 0;

    constructor(address owner) 
        ERC721("IrlaCoinERC721", "IC721")
        Ownable(owner) { }

    function _baseURI() internal pure override returns (string memory) {
        return "https://i.imgur.com/CzXTtJV.jpg";
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }
}
