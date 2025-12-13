{ pkgs, ... }:
{
  imports = [
    ./modules
  ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
  };

  # FIXME: why are these here

  programs = {
    nano.enable = false;
    vim.enable = true;
  };

  environment.systemPackages = [
    pkgs.wget
    pkgs.unzip
  ];

  time.timeZone = "Europe/Helsinki";

  # ---

  system.stateVersion = "24.11";
}
