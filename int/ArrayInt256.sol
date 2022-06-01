// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ArrayInt256 {
    function includes(int256[] storage _array, int256 _value)
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
