// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";

contract IrlaCoinERC1155 is ERC1155, Ownable, ERC1155Supply {
    constructor(address owner) ERC1155(
        ""
    ) Ownable(owner) {}

    function newURI(string memory uri) public onlyOwner {
        _setURI(uri);
    }

    function _update(address from, address to, uint256[] memory ids, uint256[] memory values) internal override(ERC1155, ERC1155Supply) {
        super._update(from, to, ids, values);
    }
}
