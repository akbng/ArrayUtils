// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeCast.sol";

library ArrayUint16 {
    using SafeCast for uint256;

    function includes(uint16[] storage _array, uint16 _value)
        internal
        view
        returns (bool)
    {
        for (uint256 i = 0; i < _array.length; i++) {
            if (_array[i] == _value) return true;
        }
        return false;
    }

    function indexOf(uint16[] storage _array, uint16 _value)
        internal
        view
        returns (int256)
    {
        for (uint256 i = 0; i < _array.length; i++) {
            if (_array[i] == _value) return i.toInt256();
        }
        return -1;
    }

    function lastIndexOf(uint16[] storage _array, uint16 _value)
        internal
        view
        returns (int256 r)
    {
        r = -1;
        for (uint256 i = 0; i < _array.length; i++) {
            if (_array[i] == _value) r = i.toInt256();
        }
    }
}
