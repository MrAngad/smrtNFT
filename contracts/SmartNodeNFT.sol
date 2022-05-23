// //SPDX-License-Identifier: Unlicense
// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
// import "@openzeppelin/contracts/security/Pausable.sol";
// import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
// import '@openzeppelin/contracts/utils/math/SafeMath.sol';
// import '@openzeppelin/contracts/access/Ownable.sol';
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
// import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
// import "@openzeppelin/contracts/utils/Strings.sol";

// contract SmartNodeNFT is ERC1155, Ownable, ReentrancyGuard, Pausable, ERC1155Supply {
//     using SafeMath for uint256;
//     using SafeERC20 for IERC20;
//     using Strings for uint256;

//     IERC20 public token = IERC20(address(0x0C2480f9CCa6518cFE191f0456cc5baf359777C3));

//     string public name   = "SmartNodeNFT";
//     string public symbol = "SMRTNFT";
//     string _baseURI      = "https://gateway.pinata.cloud/ipfs/QmZzSWdG1tKX3YQaXvMoJSLkpqyCwaYx5WWRJExmhZDDKn/";
//     uint256 public mintPrice;
//     uint256 private count = 0;

//     address TREASURY = 0x23E7E35a3A13886d242Dd457A5a76CaB7AEb9584;

//     constructor() ERC1155(_baseURI) ReentrancyGuard(){
//         pause();
//     }

//     function updateToken(IERC20 _token)public onlyOwner{
//         token = IERC20(_token);
//     }

//     function mint(uint256 _amount) external {
//         //token.safeTransferFrom(msg.sender, address(TREASURY), mintPrice.mul(_amount));
//         for(uint256 i = 0; i < _amount; i++) {
//             _mint(address(msg.sender), (count%7), 1, "0x0");
//             count += 1;
//         }
//     }

//     function tokenURI(
//     uint256 _id
//     ) external view returns (string memory) {
//         require(exists(_id), "ERC1155 uri: NONEXISTENT_TOKEN");
//         string memory baseURI = uri(_id);
//         return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, (_id+1).toString(), ".jpg")) : "";
//     }

//     function setURI(string memory _uri) external {
//         _setURI(_uri);
//     }

//     function setMintPrice(uint256 _mintPrice) public onlyOwner {
//         mintPrice = _mintPrice;
//     }

//     function pause() public onlyOwner {
//         _pause();
//     }

//     function unpause() external onlyOwner {
//         _unpause();
//     }

//     function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
//         internal
//         whenNotPaused
//         override(ERC1155, ERC1155Supply)
//     {
//         super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
//     }
// }