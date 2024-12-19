const hre = require("hardhat");

async function main() {
  
  const Degen = await hre.ethers.getContractFactory("DegenToken");
  // Deploy it
  const degen = await Degen.deploy("0xF2eab49a059504C9BCc12710B6F96d67599F63a5");
  await degen.deployed();
  // Display the contract address
  console.log(`Degen token deployed to ${degen.address}`);
  
  /*
  const Points = await hre.ethers.getContractFactory("Points");
  const points = await Points.deploy();
  await points.deployed();
  console.log(`Points token deployed to ${points.address}`);
  */
}

// Hardhat recommends this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
