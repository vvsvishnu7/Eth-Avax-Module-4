// Your task is to create a ERC20 token and deploy it on the Avalanche network for Degen Gaming. The smart contract should have the following functionality:

// Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
// Transferring tokens: Players should be able to transfer their tokens to others.
// Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
// Checking token balance: Players should be able to check their token balance at any time.
// Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//importing to use & create ERC20 token
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//importing because some actions can only performed by the owner of the contract
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20("Degen", "DGN"), Ownable {
  string public MyTokens = "" ; // This will store the info of the redeemed tokens by users.


  //This function will use the inbuilt _mint function of ERC20 Token
  // Only owner can call this function, other users can't call this function
  //onlyOwner is just like a modifier which is inbuilt in ERC20 token
  function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
  }

  // This function will use the inbuilt _transfer function of ERC20 Token
  // _transfer will take 3 parameters
  //1. Address of the user  2. address of the reciever  3. Amount/tokens to be transfer
  function transferTokens(address to, uint256 amount) external {
    _transfer(_msgSender(), to, amount);
  }


   // This function will use the inbuilt _burn function of ERC20 Token
   // _transfer will take 2 parameters 
   //1. Address of the user  2. Amount/tokens to be transfer
   function burnTokens(uint256 amount) external {
     _burn(_msgSender(), amount);
  }


  // This will show the tokens in game store
  function store() public pure returns (string memory) {
    return
            "1. MS Dhoni = 500 \n 2. Virat Kohli = 1200 \n 3. Rohit Sharma = 300 \n 4. Shikhar Dhawan = 800 \n 5. Saurav Gaunguly = 1000";
  }

  // This is a payable function which is use to redeem the token of the game store
  function redeemTokens(uint256 choice) external payable {
    require(choice >= 1 && choice <= 5, "Invalid selection"); // check the condition

    uint value; // To store the price of the token
    string memory tokenName; // To store the name of the token

    // Value and tokenName will be set according to the users choice
    if (choice == 1) {
        value = 500;
        tokenName = "MS Dhoni";
    } else if (choice == 2) {
        value = 1200;
        tokenName = "Virat Kohli";
    } else if (choice == 3) {
        value = 300;
        tokenName = "Rohit Sharma";
    } else if (choice == 4) {
        value = 800;
        tokenName = "Shikhar Dhawan";
    } else {
        value = 1000;
        tokenName = "Saurav Ganguli";
    }

    // After getting the value and tokenName, we will check this condition
    // If the condition meet then we will proceed otherwise revert the transaction
    require(balanceOf(_msgSender()) >= value, "Insufficient balance");
    _transfer(_msgSender(), owner(), value);

    // This will concatenate the name of the token to MyTokens, which we have madeearlier at the top of this contract
    MyTokens = string.concat(MyTokens, tokenName, ", ");
    }
}
