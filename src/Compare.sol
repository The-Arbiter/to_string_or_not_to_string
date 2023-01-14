// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { ERC20 } from "solmate/tokens/ERC20.sol";

/// @title Compare
/// @dev Compares string and bytes values using _bytes32ToString
contract Compare {
 
  // CUSTOMS
  error ValuesNotEqual();

  constructor() {
  }

  /// @dev Spell function which converts bytes32 to string
  // This is what we are comparing against the string concat method
  function _bytes32ToStr(bytes32 _bytes32) internal pure returns (string memory) {
        bytes memory bytesArray = new bytes(32);
        for (uint256 i; i < 32; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
    }

  // Compare two strings *without using encodePacked*
  function compareStringsWithoutPacked(string memory a, string memory b) internal view returns (bool) {
      return (keccak256(abi.encode((a))) == keccak256(abi.encode((b))));
  }

  // Compare the methods of string concatenation
  function compareValues(string memory a, bytes32 b) external {

    // abi.encodePacked method
    string memory oldMethodResult = string(abi.encodePacked(a, _bytes32ToStr(b)));
    // string.concat method
    string memory newMethodResult = string.concat(a, _bytes32ToStr(b));

    if(!compareStringsWithoutPacked(oldMethodResult,newMethodResult)){
      revert("compareValues-string-mismatch");
    }

    return;
  }
}
