// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Faucet {

    string public name;
    ERC20 public token;

    constructor(string memory _name, address _token) {
        name = _name;
        token = ERC20(_token);
    }

    function request(uint amount) public {
        require(token.balanceOf(address(this))>=amount,"Faucet seco");
        token.transfer(msg.sender,amount);
    }

}