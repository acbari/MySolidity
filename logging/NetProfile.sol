pragma solidity >=0.4.22 <0.6.0;
contract NetProfile{
    struct ContentData{
        address proposer;
        address forum;
        uint votecounter;
        bool blocked;
    }
    
    string name;
    uint public contentcounter;
    uint public minvote;
    
    mapping (address => bool) founder;
    //mapping (address => ContentData) content;
    mapping (uint => ContentData) content;
    
    constructor(string memory Name, address cofounder1, address cofounder2) public {
        name = Name;
        founder[msg.sender] = true;
        founder[cofounder1] = true;
        founder[cofounder2] = true;
        contentcounter = 0;
        minvote = 3;
    }
    
    function addForum(address _newForum) public {
        require(founder[msg.sender]);
        require(isContract(_newForum));
        content[contentcounter].proposer = msg.sender;
        content[contentcounter].forum = _newForum;
        content[contentcounter].votecounter = 1;
        contentcounter +=1;
    }
    
    function voteForum(uint number) public {
        require(founder[msg.sender]);
        content[number].votecounter +=1;
    }
    
    function blockForum(uint number) public{
        require(founder[msg.sender]);
        content[number].blocked = true;
        content[number].votecounter =0;
    }
    
    function unblockForum(uint number) public{
        require(founder[msg.sender]);
        content[number].blocked = false;
        content[number].votecounter =1;
    }
    
    function getForum(uint number) public view returns (address){
        if ( (content[number].votecounter >= 3)  && !(content[number].blocked)){
            return content[number].forum;
        }else{
            address dummy;
            return dummy;
        }
    }
     
    function getRawContent(uint number) public view returns (address){
        return content[number].forum;
    }
    
    function isContract(address _addr) private view returns (bool is_contract) {
        uint length;
        assembly {
            //retrieve the size of the code on target address, this needs assembly
            length := extcodesize(_addr)
        }
        return (length>0);
    }
}
