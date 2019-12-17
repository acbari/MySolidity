pragma solidity >=0.4.22 <0.6.0;

contract Forum {
    string public name;
    uint public contentcounter;
    
    struct konten{
        bool blacklisted;
        string data;
        mapping (address => bool) voter;
        uint votecounter; 
    }
    
    uint public adminnumber;
    uint public admincounter; 
    struct NewAdmin{
        mapping (address => bool) voter;
        uint votecounter;
        bool isAdmin;
        bool isBanned;
    }
    
    mapping (address => bool) public founder;
    mapping (address => NewAdmin) admin;
    mapping (uint => address) public listadmin;
    mapping (uint => konten) content;
    
    constructor(string memory _name, address cofounder1, address cofounder2) public {
        require(msg.sender != cofounder1 && msg.sender != cofounder2 && cofounder1 != cofounder2);
        name = _name;
        founder[msg.sender] = true;
        founder[cofounder1] = true;
        founder[cofounder2] = true;
        admincounter = 0;
        adminnumber = 0;
        contentcounter = 0;
    }
    
    function isAdmin(address _adr) private view returns (bool){
        return admin[_adr].isAdmin;
    }
    
    function isFounder(address _adr) private view returns (bool){
        return founder[_adr];
    }
    
    function checkRole() public view returns (uint){
        uint status = 2;
        if (isAdmin(msg.sender)){
            status = 1;
        }else if(isFounder(msg.sender)){
            status = 0;
        }
        return status;
    }
    
    function addAdmin(address _newAdmin) public {
        require(isFounder(msg.sender) || isAdmin(msg.sender) );
        require( !(isAdmin(_newAdmin)) && !(isFounder(_newAdmin)));
        admin[_newAdmin].votecounter = 1;
        admin[_newAdmin].voter[msg.sender] = true;
        admin[_newAdmin].isAdmin = false;
        admin[_newAdmin].isBanned = false;
        admincounter +=1;
    }
    
    function voteAdmin(address _newAdmin) public {
        require(isFounder(msg.sender));
        require( !( admin[_newAdmin].voter[msg.sender] ) );
        admin[_newAdmin].votecounter += 1;
        admin[_newAdmin].voter[msg.sender] = true;
        if (admin[_newAdmin].votecounter >= 3) {
            admin[_newAdmin].isAdmin = true;
            listadmin[adminnumber] = _newAdmin;
            adminnumber +=1 ;
        }
    }
    
    function banAdmin(address _admin) public {
        require(isFounder(msg.sender));
        admin[_admin].isAdmin = false;
    }
    
    function addContent(string memory _data) public{
        require(isFounder(msg.sender) || isAdmin(msg.sender));
        content[contentcounter].blacklisted = false;
        content[contentcounter].data = _data;
        content[contentcounter].votecounter = 0;
        content[contentcounter].voter[msg.sender] = true;
        contentcounter +=1;
    }
    
    function voteContent(uint _msgId) public {
        require(isFounder(msg.sender) || isAdmin(msg.sender));
        require( !( content[_msgId].voter[msg.sender]) );
        content[_msgId].votecounter +=1;
        content[_msgId].voter[msg.sender] = true;
    }
    
    function getRawContent(uint _msgId) public view returns (string memory){
        return content[_msgId].data;
    }
    
    function getContent(uint _msgId) public view returns (string memory){
        if ( (content[_msgId].votecounter >= 3)  && !(content[_msgId].blacklisted)){
            return content[_msgId].data;
        }else{
            return "";
        }
    }
    
    function delContent(uint _msgId) public{
        require(isFounder(msg.sender) || isAdmin(msg.sender));
        content[_msgId].blacklisted = true;
    }
    
    function revertContent(uint _msgId) public{
        require(isFounder(msg.sender));
        content[_msgId].blacklisted = false;
    }
    
    function getVoteCounter(uint _msgId) public view returns (uint){
       bool valbool = content[_msgId].voter[msg.sender];
       uint retval = 0;
       if (valbool){
           retval = 100;
           //indicate that the sender have vote for the content
       }
       return retval + content[_msgId].votecounter;
    }   
}
