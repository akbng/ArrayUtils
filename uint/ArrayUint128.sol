// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../openzeppelin/SafeCast.sol";

library ArrayUint128 {
    using SafeCast for int256;
    using SafeCast for uint256;

    // mutates the original array
    function sort(uint128[] storage _array) internal {
        if (_array.length > 1) quickSort(_array, 0, _array.length - 1);
    }

    // mutates the original array
    function quickSort(
        uint128[] storage _array,
        uint256 _low,
        uint256 _high
    ) private {
        if (_low < _high) {
            uint128 pivotVal = _array[(_low & _high) + (_low ^ _high) / 2];
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

    function isSorted(uint128[] storage _array) internal view returns (bool) {
        require(_array.length > 0, "ArrayUint256: array should not be empty");
        for (uint256 i = 0; i < _array.length - 1; i++) {
            if (_array[i] >= _array[i + 1]) return false;
        }
        return true;
    }

    function isSortedDesc(uint128[] storage _array)
        internal
        view
        returns (bool)
    {
        require(_array.length > 0, "ArrayUint256: array should not be empty");
        for (uint256 i = 0; i < _array.length - 1; i++) {
            if (_array[i] <= _array[i + 1]) return false;
        }
        return true;
    }

    function includes(uint128[] storage _array, uint128 _value)
        internal
        view
        returns (bool)
    {
        require(_array.length > 0, "ArrayUint128: array should not be empty");
        for (uint256 i = 0; i < _array.length; i++) {
            if (_array[i] == _value) return true;
        }
        return false;
    }

    function includesInSorted(uint128[] storage _array, uint128 _value)
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

    function indexOf(uint128[] storage _array, uint128 _value)
        internal
        view
        returns (int256)
    {
        require(_array.length > 0, "ArrayUint128: array should not be empty");
        for (uint256 i = 0; i < _array.length; i++) {
            if (_array[i] == _value) return i.toInt256();
        }
        return -1;
    }

    function indexOfInSorted(uint128[] storage _array, uint128 _value)
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

    function lastIndexOf(uint128[] storage _array, uint128 _value)
        internal
        view
        returns (int256 r)
    {
        require(_array.length > 0, "ArrayUint128: array should not be empty");
        r = -1;
        for (uint256 i = 0; i < _array.length; i++) {
            if (_array[i] == _value) r = i.toInt256();
        }
    }

    function at(uint128[] storage _array, int256 _index)
        internal
        view
        returns (uint128)
    {
        require(_array.length > 0, "ArrayUint128: array should not be empty");
        uint256 index = _index < 0
            ? (_array.length.toInt256() + _index).toUint256()
            : _index.toUint256();
        require(
            index < _array.length,
            "ArrayUint128: index should not be greater than array length"
        );
        return _array[index];
    }

    // mutates the original array
    function remove(uint128[] storage _array, uint256 _index) internal {
        require(_array.length > 0, "ArrayUint128: array should not be empty");
        require(
            _index < _array.length,
            "ArrayUint128: index should not be greater than array length"
        );
        _array[_index] = _array[_array.length - 1];
        _array.pop();
    }
}
