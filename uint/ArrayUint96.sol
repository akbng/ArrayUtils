// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../openzeppelin/SafeCast.sol";

/// @dev Collection of some commonly used utility function for array of type uint96
library ArrayUint96 {
    using SafeCast for int256;
    using SafeCast for uint256;

    /**
     * @dev Sort the array on which the function is called on.
     * It mutates the original array.
     * It uses the quick sorting algorithm for sorting the array.
     *
     * Requirements:
     * - input array must contain more than 1 (one) element
     */
    function sort(uint96[] storage _array) internal {
        if (_array.length > 1) quickSort(_array, 0, _array.length - 1);
    }

    /**
     * @dev Function to sort array using quick sorting algorithm.
     * This function must not be called directly.
     * It mutates the original array.
     */
    function quickSort(
        uint96[] storage _array,
        uint256 _low,
        uint256 _high
    ) private {
        if (_low < _high) {
            uint96 pivotVal = _array[(_low & _high) + (_low ^ _high) / 2];
            uint256 lv = _low;
            uint256 uv = _high;
            while (true) {
                while (_array[lv] < pivotVal) lv++;
                while (_array[uv] > pivotVal) uv--;
                if (lv >= uv) break;
                (_array[lv], _array[uv]) = (_array[uv], _array[lv]);
                lv++;
                uv--;
            }
            if (_low < uv) quickSort(_array, _low, uv);
            uv++;
            if (uv < _high) quickSort(_array, uv, _high);
        }
    }

    /**
     * @dev Returns if the given array is sorted or not.
     * Function complexity is O(n).
     * It might cost very high gas for larger arrays.
     *
     * Requirements:
     * - input array must contain more than 1 (one) element
     */
    function isSorted(uint96[] storage _array) internal view returns (bool) {
        require(_array.length > 1, "ArrayUint256: array should not be empty");
        for (uint256 i = 0; i < _array.length - 1; i++) {
            if (_array[i] >= _array[i + 1]) return false;
        }
        return true;
    }

    /**
     * @dev Returns true if the given array is sorted in descending order, false otherwise.
     * Function complexity is O(n).
     * It might cost very high gas for larger arrays.
     *
     * Requirements:
     * - input array must contain more than 1 (one) element
     */
    function isSortedDesc(uint96[] storage _array)
        internal
        view
        returns (bool)
    {
        require(_array.length > 1, "ArrayUint256: array should not be empty");
        for (uint256 i = 0; i < _array.length - 1; i++) {
            if (_array[i] <= _array[i + 1]) return false;
        }
        return true;
    }

    /**
     * @dev Returns if the given value is present in the array or not.
     * Function complexity is O(n).
     * It might cost very high gas for larger arrays.
     *
     * Requirements:
     * - input array must not be empty
     */
    function includes(uint96[] storage _array, uint96 _value)
        internal
        view
        returns (bool)
    {
        require(_array.length > 0, "ArrayUint96: array should not be empty");
        for (uint256 i = 0; i < _array.length; i++) {
            if (_array[i] == _value) return true;
        }
        return false;
    }

    /**
     * @dev Returns if the given value is present in the sorted array or not.
     * It uses binary search algorithm.
     * Function complexity is O(log n).
     *
     * Requirements:
     * - input array must be sorted in ascending order.
     */
    function includesInSorted(uint96[] storage _array, uint96 _value)
        internal
        view
        returns (bool)
    {
        require(
            isSorted(_array),
            "ArrayUint256: array should be sorted in ascending order"
        );
        uint256 lv = 0;
        uint256 uv = _array.length;
        while (lv < uv) {
            uint256 mid = (lv & uv) + (lv ^ uv) / 2;
            if (_value == _array[mid]) return true;
            if (_value > _array[mid]) lv = mid + 1;
            else uv = mid - 1;
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
    function indexOf(uint96[] storage _array, uint96 _value)
        internal
        view
        returns (int256)
    {
        require(_array.length > 0, "ArrayUint96: array should not be empty");
        for (uint256 i = 0; i < _array.length; i++) {
            if (_array[i] == _value) return i.toInt256();
        }
        return -1;
    }

    /**
     * @dev Returns the index of the given value in the array.
     * It uses binary search algorithm.
     * Function complexity is O(log n).
     *
     * Requirements:
     * - input array must be sorted in ascending order.
     */
    function indexOfInSorted(uint96[] storage _array, uint96 _value)
        internal
        view
        returns (int256)
    {
        require(
            isSorted(_array),
            "ArrayUint256: array should be sorted in ascending order"
        );
        uint256 lv = 0;
        uint256 uv = _array.length;
        while (lv < uv) {
            uint256 mid = (lv & uv) + (lv ^ uv) / 2;
            if (_value == _array[mid]) return mid.toInt256();
            if (_value > _array[mid]) lv = mid + 1;
            else uv = mid - 1;
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
    function lastIndexOf(uint96[] storage _array, uint96 _value)
        internal
        view
        returns (int256 r)
    {
        require(_array.length > 0, "ArrayUint96: array should not be empty");
        r = -1;
        for (uint256 i = 0; i < _array.length; i++) {
            if (_array[i] == _value) r = i.toInt256();
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
    function at(uint96[] storage _array, int256 _index)
        internal
        view
        returns (uint96)
    {
        require(_array.length > 0, "ArrayUint96: array should not be empty");
        uint256 index = _index < 0
            ? (_array.length.toInt256() + _index).toUint256()
            : _index.toUint256();
        require(
            index < _array.length,
            "ArrayUint96: index should not be greater than array length"
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
    function remove(uint96[] storage _array, uint256 _index) internal {
        require(_array.length > 0, "ArrayUint96: array should not be empty");
        require(
            _index < _array.length,
            "ArrayUint96: index should not be greater than array length"
        );
        _array[_index] = _array[_array.length - 1];
        _array.pop();
    }
}
