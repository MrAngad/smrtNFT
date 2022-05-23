const { BigNumber } = require("@ethersproject/bignumber");
const { expect } = require("chai");
const { ethers } = require("hardhat");
const { utils } = require("ethers")

const baseURI = "https://gateway.pinata.cloud/ipfs/QmeNHXmKJgsddKQoiBDca5Mr7irqVSJTYC98zDyFPvbQEq/";
const name   = "SmartNodeNFT";
const symbol = "SMRTNFT";

describe("Token contract", function () {
    let SmartNodeNFT, NFT, owner, addr1, addr2, addr3;

    beforeEach(async () => {
        SmartNodeNFT = await ethers.getContractFactory('SmartNodeNFT');
        NFT = await SmartNodeNFT.deploy();
        [owner, addr1, addr2, addr3, _] = await ethers.getSigners();
    });
    
    describe('Deployment', () => {
      it('Should set the right name', async() => {
          expect(await NFT.name()).to.equal(name);
      });

      it('Should set the right symbol', async() => {
          expect(await NFT.symbol()).to.equal(symbol);
      });

      it('Should set the right owner', async() => {
        expect(await NFT.owner()).to.equal(owner.address);
      });

      it('Should set the correct base URI', async() => {
        expect(await NFT.baseURI()).to.equal(baseURI);
      });

      it('Should set the correct paused state', async() => {
        expect(await NFT.paused()).to.equal(true);
      });
    });

    describe('Test pause and unpause functionality', () => {
      it('Only owner can pause the contract', async() => {
        await expect(NFT.connect(addr1).pause()).to.be.revertedWith('Ownable: caller is not the owner');
      });

      it('Only owner can unpause the contract', async() => {
        await expect(NFT.connect(addr1).unpause()).to.be.revertedWith('Ownable: caller is not the owner');
      });

      it('Unpause works', async() => {
        await NFT.unpause();
        expect(await NFT.paused()).to.equal(false);
      });

      it('Pause works', async() => {
        await NFT.unpause();
        expect(await NFT.paused()).to.equal(false);
        await NFT.pause();
        expect(await NFT.paused()).to.equal(true);
      });
    });

    describe('Test setMintPrice', () => {
      it('Only owner can set the mint price', async() => {
        await expect(NFT.connect(addr1).setMintPrice(25)).to.be.revertedWith('Ownable: caller is not the owner');
      });

      it('set mint price works', async() => {
        const mintPrice = 10;
        await NFT.setMintPrice(mintPrice)
        expect(await NFT.mintPrice()).to.equal(mintPrice);
      });

      it('Mint nft', async() => {
        const amount = 13;
        await NFT.unpause();
        await NFT.connect(addr1).mint(amount);
        await NFT.connect(addr1).mint(1);
        await NFT.connect(addr1).mint(1);
        for(let i = 0; i < 7; i++) {
          console.log(await NFT.balanceOf(addr1.address, i));
          console.log(await NFT.uri(i));
        }
      });
    });
});
