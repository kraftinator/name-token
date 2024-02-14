// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/access/Ownable.sol";
//import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";
//import {Ownable} from "../access/Ownable.sol";

contract NameToken is ERC721, Ownable {
    constructor() ERC721("NameToken", "NTK") {}

    //string[] public names;

    struct Names {
        string name;
    }

    mapping(uint256 => Names) public tokenNames;
    bool public pauseMinting = false;
    uint256 public totalSupply = 0;
    uint256 public maxSupply = 10;

    // Function to mint a new NFT with specific traits
    function mintNFT(address to, string memory name) public {
        require(pauseMinting == false, "Minting is currently paused");
        require(totalSupply < maxSupply, "Max supply reached");
        
        totalSupply += 1; // Increment the total supply
        uint256 tokenId = totalSupply; // Use totalSupply as the new tokenId
        
        // Mint the NFT using the ERC721 mint function
        _mint(to, tokenId);

        // Assign traits to the newly minted NFT
        tokenNames[tokenId] = Names(name);
    }

    // Function to retrieve the traits of a given NFT
    function getNames(uint256 tokenId) public view returns (Names memory) {
        require(_exists(tokenId), "Token does not exist.");
        return tokenNames[tokenId];
    }

    function enableMinting() public onlyOwner {
        pauseMinting = false;
    }

    function disableMinting() public onlyOwner {
        pauseMinting = true;
    }
}
