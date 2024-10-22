// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract IrlaCoinERC721 is ERC721, Ownable {
    constructor(address initialOwner) 
        ERC721("IrlaCoinERC721", "IRC")
        Ownable(initialOwner) {}

    function _baseURI() internal pure override returns (string memory) {
        return "";
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }
}
