{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  config = {
    system.stateVersion = "24.11";
  };
}
