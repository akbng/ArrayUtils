// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ArrayAddress {
    function includes(address[] storage _array, address _value)
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
