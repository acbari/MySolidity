pragma solidity ^0.5.12;

contract Logging {
    string public name;
    uint public contentcounter;
    address public owner;
    address public admin;
    mapping (uint => string) public content;
    bool public isPaused;
    
    constructor(string memory Name, address _owner) public {
        name = Name;
        admin = msg.sender;
        owner = _owner;
        contentcounter = 0;
        isPaused = false;
    }
    
    function changeOwner(address _newOwner) public {
        require(msg.sender == admin );
        owner = _newOwner;
    }
    
    function pause() public {
        require(msg.sender == admin );
        isPaused = true;
    }
    
    function unpause() public {
        require(msg.sender == admin );
        isPaused = false;
    }
    
    function addContent(string memory newContent) public {
        require(( msg.sender == owner )  && !(isPaused));
        content[contentcounter] = newContent;
        contentcounter += 1;
    }
    
    function getContent(uint _msgId) public view returns (string memory){
        return content[_msgId];
    }
    
}
