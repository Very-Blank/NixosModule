{}: {
  imports = [
    ./modules
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 2d";
  };

  time.timeZone = "Europe/Helsinki";

  system.stateVersion = "24.11";
}
