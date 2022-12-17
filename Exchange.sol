// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Exchange is Ownable {

    uint public exchangeRate;
    ERC20 public tokenInput;
    ERC20 public tokenOutput;

    constructor(address _input, address _output) {
        tokenInput = ERC20(_input);
        tokenOutput = ERC20(_output);
    }

    function setRate(uint _rate) public onlyOwner {
        exchangeRate = _rate;
    }

    function swap(uint _inputAmount) public {
        //chequear que el enviante haya aprobado los tokens
        require(tokenInput.allowance(msg.sender,address(this))==_inputAmount,"Allowance Incorrecto");
        //chequear que tenemos saldo suficiente para ejecutar la operacion
        require(tokenOutput.balanceOf(address(this))>=_inputAmount*exchangeRate,"No hay liquidez suficiente");
        tokenInput.transferFrom(msg.sender,address(this),_inputAmount);
        tokenOutput.transfer(msg.sender,_inputAmount*exchangeRate);
    }
    
    function simulate(uint _amount) public view returns(uint) {
        return _amount*exchangeRate;
    }    
    
}