// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ArrayInt64 {
    function includes(int64[] storage _array, int64 _value)
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
