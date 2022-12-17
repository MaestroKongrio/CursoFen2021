// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract SCCP is ERC20, Ownable, ERC20Permit {
    constructor() ERC20("eCCP", "eCCP") ERC20Permit("eCCP") {
        _mint(msg.sender, 50000000 * 10 ** decimals());
    }

    function decimals() pure public override returns(uint8) {
        return 0;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
