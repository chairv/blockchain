//同样发代币，注意与coin.sol的区别
contract MyToken {
    /*公有成员变量 */
    string public name;    //代币名字
    string public symbol;  //代币符号
    uint8 public decimals; //最小货币单位为小数点后几位

    /* 一个列表保存所有已发出的代币地址 */
    mapping (address => uint256) public balanceOf;

    /* 代币转让事件 */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* 构造函数
       _supply  供应量
       _name;    代币名字
       _symbol;  代币符号
       _decimals;小数位数
    */
    function MyToken(uint256 _supply, string _name, string _symbol, uint8 _decimals) {
      
        if (_supply == 0) _supply = 1000000;

        balanceOf[msg.sender] = _supply; //所有代币先发给合约创建者
        name = _name;
        symbol = _symbol;

        /* If you want a divisible token then add the amount of decimals the base unit has  */
        decimals = _decimals;
    }

    /*发送代币 */
    function transfer(address _to, uint256 _value) {
        /* 总量检查 */
        if (balanceOf[msg.sender] < _value) throw;
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;

        /*转让 */
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        /* 触发事件 */
        Transfer(msg.sender, _to, _value);
    }
}