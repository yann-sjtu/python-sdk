pragma solidity ^0.4.11;

contract SoftwareTransaction {
//关键字“public”使变量能从合约外部访问。
    address public creator;
    mapping (address => uint) public balances;
    mapping (string => address) public softwareAuthors;
    mapping (string => uint) public softwarePrices;
    mapping (string => string) softwareHashes;

//这个构造函数的代码仅仅只在合约创建的时候被运行。
    function SoftwareTransaction() public {
        creator = msg.sender;
        balances[creator] = 100000;
    }
    function mint(address receiver, uint amount) public {
        if (msg.sender != creator) return;
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public {
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
    }

    function publish(string _name, uint _price, string _hash) public {
        require(softwareAuthors[_name] == address(0), "Software was existed.");
        softwareAuthors[_name] = msg.sender;
        softwarePrices[_name] = _price;
        softwareHashes[_name] = _hash;
    }

    function buySoftware(string _name) public returns(string){
        require(softwareAuthors[_name] != address(0), "Software was not existed.");
        if (balances[msg.sender] < softwarePrices[_name]) return "";
        balances[msg.sender] -= softwarePrices[_name];
        balances[softwareAuthors[_name]] += softwarePrices[_name];
        return softwareHashes[_name]

    }
}