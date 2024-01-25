// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract KnowledgeNFT is ERC721 {
    uint256 public tokenCounter;
    mapping (uint256 => string) public knowledgeData;

    constructor() ERC721("KnowledgeNFT", "KNFT") {
        tokenCounter = 0;
    }

    function createKnowlegde(string memory knowledge) public {
        knowledgeData[tokenCounter] = knowledge;
        _mint(msg.sender, tokenCounter);
        tokenCounter++;
    }

    function getKnowledge(uint256 tokenId) public view returns (string memory) {
        return knowledgeData[tokenId];
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://";
    }
}

contract KnowledgeToken is ERC20, Ownable, ERC20Permit {
    constructor(address initialOwner)
        ERC20("KnowledgeToken", "KTK")
        Ownable(initialOwner)
        ERC20Permit("KnowledgeToken")
    {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }

    function reward(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

contract IKnowledgeNFT {
    function createKnowlegde(string memory knowledge) public {}
}

contract IKnowledgeToken {
    function reward(address to, uint256 amount) public {}
}

contract KnowledgeSystem {
    address IKnowledgeNFTAddress = 0xaaaaaaaaaaa;
    IKnowledgeNFT nftContract = IKnowledgeNFT(IKnowledgeNFTAddress)

    address IKnowledgeTokenAddress = 0xbbbbbbbbbbbbb;
    IKnowledgeToken tokenContract = IKnowledgeToken(IKnowledgeTokenAddress)

    uint256 amount = 100;
    function createKnowledge(string memory knowledge) public {
        nftContract.createKnowlegde(knowledge);
        tokenContract.reward(msg.sender, amount);
    }
}