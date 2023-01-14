// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

import {Compare} from "src/Compare.sol";

contract CompareTest is Test {
    using stdStorage for StdStorage;

    Compare compare;

    function setUp() external {
        compare = new Compare();
    }

    function testCompareValues(string memory a, bytes32 b) external {
        compare.compareValues(a,b);
    }
}
