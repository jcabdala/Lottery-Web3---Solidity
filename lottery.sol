// SPDX-License-Identifier: MIT
pragma solidity <= 0.86;
pragma experimental ABIEncoderV2;

contract lottery {
    address public owner;
    address public winner;
    address[] participants ;

    // Events
    event lottery_done(string, address);
    event user_registry(string);

    //??
    constructor () public {
        owner = msg.sender;
    }
    
    modifier OnlyOwner(address _address){
        require(_address == owner, "Only Owner!");
        _;
    }

    function RegisterInLottery(address _address) public {
        participants.push(_address);
        emit user_registry("User successfully registered");
    }
    
    function CheckParticipants() public view OnlyOwner(msg.sender) returns (address[] memory){
        return participants;
    }
    
    // Solidity pseudo-random function:
    function random() private view returns (uint) {
     return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants)));
    }

    // invoke random function in a pickWinner example function
    function pickWinner() public OnlyOwner(msg.sender) returns (address) {
        uint index = random()%participants.length;
        winner =  participants[index];
        emit lottery_done("We have a winner", winner);
        return winner;
    }

}
