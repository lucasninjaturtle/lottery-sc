// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract Lottery {
    address payable public manager;
    address payable [] public players;
    
    function LotteryManager() public {
        manager = payable(msg.sender);
    }
    
    function enter() public payable {
        require(msg.value > .01 ether);
        players.push(manager);
    }
    
    function random() private view returns (uint) {
        uint randomnum_ = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
        return randomnum_;
    }
    
    function pickWinner() public restricted {
        uint index = random() % players.length;
        
        players[index].transfer(address(this).balance);
        players = new address payable[](0);
    }
    
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
    
    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }
}   