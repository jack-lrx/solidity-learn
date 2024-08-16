// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface ITest {
    function val() external view returns (uint256);
    function test() external ;
}

contract Callback {
    uint256 public val;

    fallback() external {
        val = ITest(msg.sender).val();
    }

    function test(address target) external {
        ITest(target).test();
    }
}

contract TestStorage {
    uint256 public val;

    function test() public {
        val = 123;
        bytes memory b = "";
        msg.sender.call(b);
    }
}

contract TestTransientStorage {
    bytes32 constant SLOT = 0;
    
    function test() public {
        //内联汇编（assembly）允许开发者编写更底层的代码，直接操作以太坊虚拟机（EVM）的指令 
        assembly {
            // 功能: tstore 用于将数据存储到以太坊的临时存储（transient storage）中。临时存储的数据只在当前交易中有效，一旦交易结束，数据就会被清除。
            // 成本: tstore 操作的成本较低，因为它只涉及到当前交易的存储操作，不涉及持久化存储。
            // 使用场景: 用于存储只在当前交易中需要的数据，如临时变量、临时计算结果等。
            tstore(SLOT, 321)
        }
        bytes memory b ="";
        msg.sender.call(b);
    }

    function val() public view returns (uint256 v) {
        assembly {
            // := 是汇编中的赋值运算符，用于将结果赋值给 v
            // tload: 用于从交易的临时存储中读取数据，适用于只在当前交易中有效的数据，成本较低。
            v := tload(SLOT)
        }
    }
}

contract ReentrancyGuard {
    bool private locked;

    modifier lock() {
        require(!locked);
        locked = true;
        _;
        locked = false;
    }

    function test() public lock {
        bytes memory b = "";
        msg.sender.call(b);
    }
}

contract ReentrancyGuardTransient {
    bytes32 constant SLOT = 0;

    modifier lock() {
        assembly {
            if tload(SLOT) {revert(0,0)}
            tstore(SLOT, 1)
        }
        _;
        assembly {
            tstore(SLOT, 0)
        }
    }

    function test() external lock {
        bytes memory b = "";
        msg.sender.call(b);
    }
}