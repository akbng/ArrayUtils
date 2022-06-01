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
            if (equals(_array[i], _value)) return true;
        }
        return false;
    }

    function indexOf(string[] storage _array, string memory _value)
        internal
        view
        returns (int256)
    {
        for (uint256 i = 0; i < _array.length; i++) {
            if (equals(_array[i], _value)) return i.toInt256();
        }
        return -1;
    }

    function lastIndexOf(string[] storage _array, string memory _value)
        internal
        view
        returns (int256 r)
    {
        r = -1;
        for (uint256 i = 0; i < _array.length; i++) {
            if (equals(_array[i], _value)) r = i.toInt256();
        }
    }

    function equals(string memory a, string memory b)
        private
        pure
        returns (bool)
    {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}
