// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract NestedMapping {
    mapping (address => mapping (uint256 => bool)) public nested;

    function get(address _addr, uint256 _i) public returns (bool) {
        return nested[_addr][_i];
    }

    function set(address _addr, uint256 _i, bool _boo) public {
        nested[_addr][_i] = _boo;
    }

    function remove(address _addr, uint256 _i) public {
        delete nested[_addr][_i];
    }
}