// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeCast.sol";

library ArrayString {
    using SafeCast for uint256;

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

    function indexOf(string[] storage _array, string memory _value)
        internal
        view
        returns (int256)
    {
        for (uint256 i = 0; i < _array.length; i++) {
            if (
                keccak256(abi.encodePacked(_array[i])) ==
                keccak256(abi.encodePacked(_value))
            ) return i.toInt256();
        }
        return -1;
    }
}
