// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract BulkSendETH {
    address payable public owner;
    uint public ethAmount = 0.005 ether;

    constructor() {
        owner = payable(msg.sender);
    }

    function sendOutFunds(address payable[] memory _to) public onlyOwner {
        uint totalAmount = ethAmount * _to.length;
        require(address(this).balance >= totalAmount, "Insufficient contract balance");

        for (uint i = 0; i < _to.length; i++) {
            _to[i].transfer(ethAmount);
        }
    }

    function withdraw() public onlyOwner {
        owner.transfer(address(this).balance);
    }

    function transferOwnership(address payable newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner address cannot be zero address");
        owner = newOwner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    receive() external payable {}
    fallback() external payable {}
}
