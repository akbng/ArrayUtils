// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../openzeppelin/SafeCast.sol";

library ArrayUint256 {
    using SafeCast for int256;
    using SafeCast for uint256;

    // mutates the original array
    function sort(uint256[] storage _array) internal {
        if (_array.length > 1) quickSort(_array, 0, _array.length - 1);
    }

    // mutates the original array
    function quickSort(
        uint256[] storage _array,
        uint256 _low,
        uint256 _high
    ) private {
        if (_low < _high) {
            uint256 pivotVal = _array[(_low + _high) / 2];
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

    function isSorted(uint256[] storage _array) internal view returns (bool) {
        require(_array.length > 0, "ArrayUint256: array should not be empty");
        for (uint256 i = 0; i < _array.length - 1; i++) {
            if (_array[i] >= _array[i + 1]) return false;
        }
        return true;
    }

    function isSortedDesc(uint256[] storage _array)
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

    // this function would consume **HIGH GAS** for long arrays
    function includes(uint256[] storage _array, uint256 _value)
        internal
        view
        returns (bool)
    {
        require(_array.length > 0, "ArrayUint256: array should not be empty");
        for (uint256 i = 0; i < _array.length; i++) {
            if (_array[i] == _value) return true;
        }
        return false;
    }

    function includesInSorted(uint256[] storage _array, uint256 _value)
        internal
        view
        returns (bool)
    {
        require(_array.length > 0, "ArrayUint256: array should not be empty");
        require(
            isSorted(_array),
            "ArrayUint256: array should be sorted in ascending order"
        );
        uint256 lv = 0;
        uint256 uv = _array.length;
        while (lv < uv) {
            uint256 mid = (lv + uv) / 2;
            if (_value == _array[mid]) return true;
            lv = _value > _array[mid] ? mid + 1 : lv;
            uv = _value < _array[mid] ? mid - 1 : uv;
        }
        return false;
    }

    // this function would consume **HIGH GAS** for long arrays
    function indexOf(uint256[] storage _array, uint256 _value)
        internal
        view
        returns (int256)
    {
        require(_array.length > 0, "ArrayUint256: array should not be empty");
        for (uint256 i = 0; i < _array.length; i++) {
            if (_array[i] == _value) return i.toInt256();
        }
        return -1;
    }

    function indexOfInSorted(uint256[] storage _array, uint256 _value)
        internal
        view
        returns (int256)
    {
        require(_array.length > 0, "ArrayUint256: array should not be empty");
        require(
            isSorted(_array),
            "ArrayUint256: array should be sorted in ascending order"
        );
        uint256 lv = 0;
        uint256 uv = _array.length;
        while (lv < uv) {
            uint256 mid = (lv + uv) / 2;
            if (_value == _array[mid]) return mid.toInt256();
            lv = _value > _array[mid] ? mid + 1 : lv;
            uv = _value < _array[mid] ? mid - 1 : uv;
        }
        return -1;
    }

    // this function would consume **HIGH GAS** for long arrays
    function lastIndexOf(uint256[] storage _array, uint256 _value)
        internal
        view
        returns (int256 r)
    {
        require(_array.length > 0, "ArrayUint256: array should not be empty");
        r = -1;
        for (uint256 i = 0; i < _array.length; i++) {
            if (_array[i] == _value) r = i.toInt256();
        }
    }

    function at(uint256[] storage _array, int256 _index)
        internal
        view
        returns (uint256)
    {
        require(_array.length > 0, "ArrayUint256: array should not be empty");
        uint256 index = _index < 0
            ? (_array.length.toInt256() + _index).toUint256()
            : _index.toUint256();
        require(
            index < _array.length,
            "ArrayUint256: index should not be greater than array length"
        );
        return _array[index];
    }

    // mutates the original array
    function remove(uint256[] storage _array, uint256 _index) internal {
        require(_array.length > 0, "ArrayUint256: array should not be empty");
        require(
            _index < _array.length,
            "ArrayUint256: index should not be greater than array length"
        );
        _array[_index] = _array[_array.length - 1];
        _array.pop();
    }
}
