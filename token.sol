// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract FenToken is ERC20, Ownable {
    
    constructor (string memory name_, string memory symbol_, uint amount) ERC20(name_,symbol_) {
        _mint(msg.sender,amount);
    }
    
    function decimals() public pure override returns (uint8) {
        return 0;
    }
    
}

contract PatoCompany {
    
    FenToken public token;
    
    struct propuesta {
        string texto;
        uint votoFavor;
        uint votoContra;
        bool cerrada;
    }
    
    mapping(uint=>propuesta) public propuestas;
    mapping(uint=>mapping(address=>bool)) registroVotos;
    
    constructor(address _token) public {
        token = FenToken(_token);
    }
    
    function proponer(uint _codigo, string memory _texto) public {
        propuestas[_codigo] = propuesta(_texto,0,0,false);
    }
    
    function votarSi(uint codigo) public {
        require(!registroVotos[codigo][msg.sender],"ya votaste");
        registroVotos[codigo][msg.sender]=true;
        propuestas[codigo].votoFavor+=token.balanceOf(msg.sender);
    }
    
    function votarNo(uint codigo) public {
        require(!registroVotos[codigo][msg.sender],"ya votaste");
        registroVotos[codigo][msg.sender]=true;
        propuestas[codigo].votoContra+=token.balanceOf(msg.sender);
    }
    
}

contract PreSale is Ownable {
    
    uint public saldo;
    mapping(address=>uint) public aporte;
    FenToken public token;
    bool public liquidando;
    address public empresa;

    constructor(uint amount) {
        FenToken _token = new FenToken("PatoSale","PTT",amount);
        token = _token;
        saldo=0;
        liquidando=false;
        PatoCompany _empresa = new PatoCompany(address(_token));
        empresa= address(_empresa);
    }
    
    function aportar() payable public {
        require(!liquidando,"Los aportes estan cerrados");
        require(msg.value >= 1 ether,"Su aporte es muy bajo");
        aporte[msg.sender] += msg.value;
        saldo += msg.value;
    }
    
    function liquidar() public onlyOwner {
        liquidando=true;
        payable(owner()).transfer(address(this).balance);
    }
    
    function retirar() public returns (uint) {
        require(aporte[msg.sender]>=1 ether,"No tiene voto para retirar");
        uint votos = (aporte[msg.sender]*token.totalSupply())/this.saldo();
        aporte[msg.sender] = 0;
        token.transfer(msg.sender,votos);
        return votos;
    }
    
}

