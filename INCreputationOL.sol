pragma solidity ^0.5.2;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev sets the original `owner` of the contract to OL
     * account.
     */
    constructor () internal {
        _owner = "0x077086E2bc65a728E2aE0d7E22e4A767cE7802b3";
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @return the address of the owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner());
        _;
    }

    /**
     * @return true if `msg.sender` is the owner of the contract.
     */
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    /**
     * @dev Allows the current owner to relinquish control of the contract.
     * It will not be possible to call the functions with the `onlyOwner`
     * modifier anymore.
     * @notice Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0));
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw an error.
 * Based off of https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/math/SafeMath.sol.
 */
library SafeMath {
    /*
     * Internal functions
     */

    function mul(uint256 a, uint256 b)
        internal
        pure
        returns (uint256)
    {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b)
        internal
        pure
        returns (uint256)
    {
        uint256 c = a / b;
        return c;
    }

    function sub(uint256 a, uint256 b)
        internal
        pure
        returns (uint256) 
    {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b)
        internal
        pure
        returns (uint256) 
    {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

contract INCreputation is Ownable {
  mapping(address => uint256) public reputation;
  using SafeMath for uint256; 

  function joinINC(address _contributor) public {
    reputation[_contributor] = 9;
  }
  
  function isinGoodStanding(address x) public view returns (bool) {
    return reputation[x] > 0;
  }

  function reportINCviolation(address reportedcontributor) public onlyOwner {
    reputation[reportedcontributor] = reputation[reportedcontributor].sub(1); 
  }
  
  function repairINCreputation(address reinstated) public onlyOwner {
    require(reputation[reinstated] < 9);
    reputation[reinstated] = reputation[reinstated].add(1); 
  }
}
