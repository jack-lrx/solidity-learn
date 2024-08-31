// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "./ERC721.sol";

contract RCCApe is ERC721 {
    uint public MAX_APES = 10000; //总量

    //构造函数
    constructor(string memory _name, string memory _symbol) ERC721 (_name, _symbol) {
    }

    function _baseURI() internal pure override returns(string memory){
        return "ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/";
    }

    function mint(address to, uint _tokenId) external {
        require(_tokenId >= 0 && _tokenId < MAX_APES, "tokenId out of range");
        _mint(to, _tokenId);
    }
}