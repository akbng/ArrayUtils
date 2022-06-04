// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../openzeppelin/SafeCast.sol";

/// @dev Collection of some commonly used utility function for array of type string
library ArrayString {
    using SafeCast for int256;
    using SafeCast for uint256;

    /**
     * @dev Returns if the given value is present in the array or not.
     * Function complexity is O(n).
     * It might cost very high gas for larger arrays.
     *
     * Requirements:
     * - input array must not be empty
     */
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

    /**
     * @dev Returns the index of the given value in the array.
     * Function complexity is O(n).
     * It might cost very high gas for larger arrays.
     *
     * Requirements:
     * - input array must not be empty
     */
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

    /**
     * @dev Returns the last found index of the given value in the array.
     * Function complexity is O(n).
     * It might cost very high gas for larger arrays.
     *
     * Requirements:
     * - input array must not be empty
     */
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

    /**
     * @dev Returns the element present at the given index of the array.
     * It supports negative indexing where -1 means the last element and -length = first element.
     * Function complexity is O(1).
     *
     * Requirements:
     * - input array must not be empty
     * - index must not be greater than the array length
     */
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

    /**
     * @dev Remove an element from a given index of the array.
     * It changes the order of the array.
     * It mutates the original array.
     * Function complexity is O(1).
     *
     * Requirements:
     * - input array must not be empty
     * - index must not be greater than the array length
     */
    function remove(string[] storage _array, uint256 _index) internal {
        require(_array.length > 0, "ArrayString: array should not be empty");
        require(
            _index < _array.length,
            "ArrayString: index should not be greater than array length"
        );
        _array[_index] = _array[_array.length - 1];
        _array.pop();
    }

    /**
     * @dev Function to check equality of two strings.
     * This function must not be called from outside.
     */
    function equals(string memory a, string memory b)
        private
        pure
        returns (bool)
    {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}
