// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract IrlaCoinERC20 is ERC20, ERC20Permit {
    uint256 fee = 100;
    uint256 price = 10;
    address public owner;

    constructor() ERC20("IrlaCoin", "IRC") ERC20Permit("IrlaCoin") {
        owner = msg.sender;
        _mint(msg.sender, 10000000 * 10 ** decimals()); 
    }

    function buyTokens() external payable {
        uint256 tokensToBuy = msg.value / price;
        _mint(msg.sender, tokensToBuy);
    }

    // MARK :- ERC20

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        uint256 amountAfterFee = amount - fee;

        _transfer(msg.sender, owner, fee);
        _transfer(msg.sender, recipient, amountAfterFee);

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
        _transfer(from, owner, fee);
    }
}
