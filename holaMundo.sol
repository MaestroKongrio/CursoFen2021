pragma solidity ^0.8;

contract HolaMundo {
    
    string frase;
    
    constructor (string memory _frase) {
        frase=_frase;
    }
    
    function setFrase(string memory _frase) public {
        frase=_frase;
    }
    
    function getFrase() public view returns (string memory) {
        return frase;
    }
}
