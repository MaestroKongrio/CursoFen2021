// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Hashlock {

    bytes32 secret;
    address target;

    constructor(bytes32 _secret,address _target) payable {
        secret=_secret;
        target = _target;
    }

    function withdraw(string memory _thesecret) public {
        require(keccak256(abi.encodePacked(_thesecret))==secret,"invalid secret");
        payable(target).transfer(address(this).balance);
    }

}

contract Hasher{

    function getHash(string memory _secret) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(_secret));
    }
}