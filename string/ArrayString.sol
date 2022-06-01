// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ArrayString {
    function includes(string[] storage _array, string memory _value)
        internal
        view
        returns (bool)
    {
        for (uint256 i = 0; i < _array.length; i++) {
            if (
                keccak256(abi.encodePacked(_array[i])) ==
                keccak256(abi.encodePacked(_value))
            ) return true;
        }
        return false;
    }
}
