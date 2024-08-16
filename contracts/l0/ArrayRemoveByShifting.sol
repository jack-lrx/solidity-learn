// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ArrayRemoveByShifting {
    uint256[] public arr;

    function remove(uint256 index) public  {
        require(index<arr.length, "index out of bount");

        for (uint256 i = index; i<arr.length-1; i++) 
        {
            arr[i] = arr[i+1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1,2,3,4,5];
        remove(2);
        assert(arr[0]==1);
        assert(arr[1]==2);
        assert(arr[2]==4);
        assert(arr[3]==5);
        assert(arr.length == 4);

        arr =[1];
        remove(0);
        assert(arr.length == 0);
    }
}