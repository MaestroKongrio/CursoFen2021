// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./message.sol";

contract SCLP is ERC20, Ownable {

    constructor() ERC20("eCLP", "eCLP") {
        _mint(msg.sender, 10000000 * 10 ** decimals());
    }

    function decimals() pure public override returns(uint8) {
        return 0;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
 
}