{
  lib,
  config,
  ...
}: {
  imports = [
    ./sops
    ./desktop
    ./boot
    ./hardware
    ./developer
    ./server
    ./essential
    ./home
    ./terminal
    ./graphical
    ./tty
  ];

  options = {
    hostname = lib.mkOption {
      default = "nixos";
      description = "The system hostname.";
      type = lib.types.nonEmptyStr;
    };

    modules = {
      unfreePackages = lib.mkOption {
        type = with lib.types; listOf nonEmptyStr;
        default = [];
        description = "Packages that are unfree that should be allowed.";
      };
    };
  };

  config = {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.modules.unfreePackages;

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
  };
}
