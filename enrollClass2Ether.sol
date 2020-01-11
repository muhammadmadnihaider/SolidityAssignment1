pragma solidity ^0.5.0;

contract EnrollStudents{
    
    address payable private myAddress;
        enum gender{
            male,
            female
        }
        enum addmissionType{
            onsite,
            online
        }
    struct Student{
        string name;
        bool haveBSDegree;
        gender studentGender;
        addmissionType studentAddmissionType;
    }
    
    constructor() public {
        myAddress = msg.sender;
    }
    
    mapping(address => Student) addressToStudents;
    
    modifier isActualfee(uint value){
        if(value == 2000000000000000000){
            _;
        }
    }
    
    function getAddmission(string memory name, bool haveBSDegree, gender yourGender, addmissionType OnlineOrOnsite) isActualfee(msg.value) public payable {
       Student memory _studentStruct = Student(name, haveBSDegree, yourGender, OnlineOrOnsite);
       addressToStudents[msg.sender] = _studentStruct;
       myAddress.transfer(msg.value);
    }
    modifier isOwner(address Address){
        if(Address == myAddress){
            _;
        }
    }
    
    function getTotalAmount() public view isOwner(msg.sender) returns(uint) {
        return myAddress.balance;
    }
    
    function addressToStudentsfunction(address Address) public view isOwner(msg.sender) returns(string memory _name, bool _degree, gender _Gender, addmissionType _addmissionType){
        Student memory structOfStud = addressToStudents[Address];
        _name = structOfStud.name;
        _degree = structOfStud.haveBSDegree;
        _Gender = structOfStud.studentGender;
        _addmissionType = structOfStud.studentAddmissionType;
    }
    
    
    
}