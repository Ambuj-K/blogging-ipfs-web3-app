// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "forge-std/Test.sol";
import "../src/Medium.sol";

contract MediumTest is DSTest {
    Medium public md;
    function setUp() public {
        md = new Medium();
        address addr = 0x1234567890123456789012345678901234567890;
        md.safeMint{value: 2 ether}(addr, "ipfs://QmYgb3tawCnMGPMV4DGFawNznEBzoFNXsZNwvTPDB4mZxc");
    }

    function testSafeMint() public {
        address addr = 0x1234567890123456789012345678901234567890;
        address owner = md.ownerOf(0);
        assertEq(addr, owner);
    }

    // function testSetNumber(uint256 x) public {
    //     counter.setNumber(x);
    //     assertEq(counter.number(), x);
    // }

    fallback() external payable {}

    receive() external payable {}
}
