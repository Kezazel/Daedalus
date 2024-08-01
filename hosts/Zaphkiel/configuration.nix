{...}: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
    ../../users/rexies
  ];

  networking.hostName = "Zaphkiel";

  graphics = {
    amd.enable = true;
    nvidia.enable = true;
  };

  anime-games.enable = true;

  system.stateVersion = "23.11";
}
