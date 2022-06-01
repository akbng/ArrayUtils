// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeCast.sol";

library ArrayString {
    using SafeCast for int256;
    using SafeCast for uint256;

    function includes(string[] storage _array, string memory _value)
        internal
        view
        returns (bool)
    {
        require(_array.length > 0, "ArrayString: array should not be empty");
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
        require(_array.length > 0, "ArrayString: array should not be empty");
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
        require(_array.length > 0, "ArrayString: array should not be empty");
        r = -1;
        for (uint256 i = 0; i < _array.length; i++) {
            if (equals(_array[i], _value)) r = i.toInt256();
        }
    }

    function at(string[] storage _array, int256 _index)
        internal
        view
        returns (string memory)
    {
        require(_array.length > 0, "ArrayString: array should not be empty");
        uint256 index = _index < 0
            ? (_array.length.toInt256() + _index).toUint256()
            : _index.toUint256();
        require(
            index < _array.length,
            "ArrayString: index should not be greater than array length"
        );
        return _array[index];
    }

    function equals(string memory a, string memory b)
        private
        pure
        returns (bool)
    {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}
