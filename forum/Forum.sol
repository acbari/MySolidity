pragma solidity ^0.4.18;

contract Forum {
    string public name;
    uint public contentcounter;
    
    struct konten{
        bool blacklisted;
        string data;
        mapping (address => bool) voter;
        uint votecounter; 
    }
    
    uint private maxAdmin;
    uint private admincounter; 
    struct NewAdmin{
        mapping (address => bool) voter;
        uint votecounter;
        bool isAdmin;
    }
    
    mapping (address => bool) founder;
    mapping (address => NewAdmin) admin;
    mapping (uint => konten) content;
    
    constructor(string Name, address cofounder1, address cofounder2, uint  _maxAdmin) public {
        name = Name;
        founder[msg.sender] = true;
        founder[cofounder1] = true;
        founder[cofounder2] = true;
        maxAdmin = _maxAdmin;
        admincounter = 0;
        contentcounter = 0;
    }
    
    function isAdmin(address _adr) private view returns (bool){
        return admin[_adr].isAdmin;
    }
    
    function isFounder(address _adr) private view returns (bool){
        return founder[_adr];
    }
    
    function addAdmin(address _newAdmin) public {
        require(isFounder(msg.sender) || isAdmin(msg.sender) );
        require( !(isAdmin(_newAdmin)) && !(isFounder(_newAdmin)) );
        admin[_newAdmin].votecounter = 1;
        admin[_newAdmin].voter[msg.sender] = true;
        admin[_newAdmin].isAdmin = false;
    }
    
    function voteAdmin(address _newAdmin) public {
        require(isFounder(msg.sender));
        require( !( admin[_newAdmin].voter[msg.sender] ) );
        admin[_newAdmin].votecounter += 1;
        admin[_newAdmin].voter[msg.sender] = true;
        if (admin[_newAdmin].votecounter >= 3) {
            admin[_newAdmin].isAdmin = true;
        }
    }
    
    function delAdmin(address _admin) public {
        require(isFounder(msg.sender));
        admin[_admin].isAdmin = false;
    }
    
    function addContent(string _data) public{
        require(isFounder(msg.sender) || isAdmin(msg.sender));
        content[contentcounter].blacklisted = false;
        content[contentcounter].data = _data;
        content[contentcounter].votecounter = 1;
        content[contentcounter].voter[msg.sender] = true;
        contentcounter +=1;
    }
    
    function voteContent(uint _msgId) public {
        require(isFounder(msg.sender) || isAdmin(msg.sender));
        require( !( content[_msgId].voter[msg.sender]) );
        content[_msgId].votecounter +=1;
        content[_msgId].voter[msg.sender] = true;
    }
    
    function getContent(uint _msgId) public view returns (string){
        if ( (content[_msgId].votecounter > 3)  && !(content[_msgId].blacklisted)){
            return content[_msgId].data;
        }else{
            return "";
        }
    }
    
    function getRawContent(uint _msgId) public view returns (string){
        return content[_msgId].data;
    }
    
    function delContent(uint _msgId) public{
        require(isFounder(msg.sender) || isAdmin(msg.sender));
        content[_msgId].blacklisted = true;
    }
    
    function revertContent(uint _msgId) public{
        require(isFounder(msg.sender));
        content[_msgId].blacklisted = false;
    }
    
}
