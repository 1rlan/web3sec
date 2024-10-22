// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract IrlaCoinERC20 is ERC20, ERC20Permit, Ownable {
    uint256 fee = 100;
    uint256 price = 10;

    constructor(address owner) ERC20("IrlaCoin", "IRC") ERC20Permit("IrlaCoin") Ownable(owner) {
        _mint(msg.sender, 10000000 * 10 ** decimals()); 
    }

    // MARK :- ERC20

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function buy(address to) public payable {
        _mint(to, msg.value);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _sendAndSaveFees(msg.sender, recipient, amount);

        return true;
    }

    function transferFrom(address from, address to, uint256 value) public override returns (bool) {
        _spendAllowance(from, msg.sender, value);
        _sendAndSaveFees(from, to, value);

        return true;
    }

    // MARK :- Private methods

    function _sendAndSaveFees(address from, address to, uint256 amount) private {
        uint256 amountAfterFee = amount - fee;

        _transfer(from, to, amountAfterFee);
        _transfer(from, owner(), fee);
    }
}
