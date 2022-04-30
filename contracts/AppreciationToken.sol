//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract AppreciationToken is ERC721 {
    uint256 public _currentTokenId = 0;//Token ID here will start from 1
    mapping(uint => string) public getTokenURI; // tokenId => tokenURI

    mapping(address => address) public getNameFromAddress;
    address[] public allMinters;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {
    }

    /**
     * @dev Mints a token to an address with a tokenURI.
     * @param _to address of the future owner of the token
     * @param tokenURI token URI
     */
    function mintTo(address _to, string memory _tokenURI) public returns (uint256) {
        uint256 newTokenId = _getNextTokenId();
        _mint(_to, newTokenId);
        _incrementTokenId();
        _setTokenURI(newTokenId, _tokenURI);
        if (getNameFromAddress[msg.sender] == address(0)) {
            allMinters.push(msg.sender);
        }
        return newTokenId;
    }

    function _setTokenURI(uint newTokenId, string memory _tokenURI) public {
        getTokenURI[newTokenId] = _tokenURI;
    }

    function getNextTokenImageId() public view returns (uint256) {
        return (_currentTokenId + 1) % 41;
    }

    /**
     * @dev calculates the next token ID based on value of _currentTokenId
     * @return uint256 for the next token ID
     */
    function _getNextTokenId() private view returns (uint256) {
        return _currentTokenId+1;
    }

    /**
     * @dev increments the value of _currentTokenId
     */
    function _incrementTokenId() private {
        _currentTokenId++;
    }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return getTokenURI[tokenId];
    }

    // /**
    //  * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
    //  * token will be the concatenation of the `baseURI` and the `tokenId`. Empty
    //  * by default, can be overriden in child contracts.
    //  */
    // function _baseURI() internal view virtual override returns (string memory) {
    //     return "ipfs://bafkreifn4wzv5n2yztmwjlyoovnhrmcqqtqv4igltwi3z4anxsbnh4oqni";
    // }

    function getAllMinters() public view returns (address[] memory) {
        return allMinters;
    }
}
