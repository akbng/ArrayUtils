// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ArrayInt96 {
    function includes(int96[] storage _array, int96 _value)
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
