// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ArrayUint64 {
    function includes(uint64[] storage _array, uint64 _value)
        internal
        view
        returns (bool)
    {
        for (uint256 i = 0; i < _array.length; i++) {
            if (_array[i] == _value) return true;
        }
        return false;
    }
}
