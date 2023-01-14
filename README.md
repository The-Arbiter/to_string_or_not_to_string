# To String or not To String

## About

Here I compare `abi.encodePacked()` and `string.concat` with the use of the `_bytes32ToString` helper function.

The purpose of this is to investigate whether leading zeroes in bytes32 values could lead to the output of these two methods being different.

It should be noted that string comparison using abi.encodePacked() *could* be used but to avoid potential true negatives I am using abi.encode() for string comparison (although it shouldn't matter since they're strings anyway).

## Rationale

abi.encodePacked() should remove leading zeroes

*However, according to solidity docs:*

> You can concatenate an arbitrary number of string values using string.concat. The function returns a single string memory array that contains the contents of the arguments without padding.

The question here is whether for a string `a` and bytes32 `b`, the resulting concatenated strings are equivalent. The real question being asked here is whether `string()` removes trailing zeroes when casting from `bytes32`. 

Although I couldn't (quickly) make string(abi.encode()) work nicely with keccak hash comparison, I am *reasonably confident* that `string()` does the same kind of thing as `abi.encodePacked()` under the hood in that it ignores leading zeroes.

i.e. `string(0x0000000000000000000000000000000000000000000000000000000000001111) as bytes32 is equal to string(0x1111) as bytes4`

## Results

```rust

[⠊] Compiling...
No files changed, compilation skipped

Running 1 test for test/Compare.t.sol:CompareTest
[PASS] testCompareValues(string,bytes32) (runs: 1000000, μ: 23109, ~: 23181)
Traces:
  [22816] CompareTest::testCompareValues(4, 0x0000000000000000000000000000000000000000000000000000000000000001) 
    ├─ [16989] Compare::compareValues(4, 0x0000000000000000000000000000000000000000000000000000000000000001) 
    │   └─ ← ()
    └─ ← ()

Test result: ok. 1 passed; 0 failed; finished in 119.83s

```
