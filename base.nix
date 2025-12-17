{ ... }:
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

  system.stateVersion = "25.11";
}
