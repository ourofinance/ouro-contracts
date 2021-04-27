import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
  const { deployments, getNamedAccounts } = hre;
  const { deploy } = deployments;

  const { deployer } = await getNamedAccounts();

  await deploy("Timelock", {
    from: deployer,
    args: [deployer],
    log: true,
    deterministicDeployment: false,
  });
};

export default func;
func.tags = ["Timelock"];
