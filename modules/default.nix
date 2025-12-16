{ lib, config, ... }:
{
  imports = [
    ./boot
    ./hardware
    ./developer
    ./essential
    ./home
    ./terminal
    ./networking
    ./graphical
    ./tty
  ];

  options = {
    modules = {
      unfreePackages = lib.mkOption {
        type = with lib.types; listOf nonEmptyStr;
        default = [ ];
        description = "Packages that are unfree that should be allowed.";
      };
    };
  };

  config = {
    nixpkgs.config.allowUnfreePredicate =
      pkg: builtins.elem (lib.getName pkg) config.modules.unfreePackages;
  };
}
