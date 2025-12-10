{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    modules = {
      graphical = {
        obsidian = {
          enable = lib.mkEnableOption "Obsidian";
        };
      };
    };
  };

  config = lib.mkIf config.modules.graphical.obsidian.enable {
    nixpkgs.config.allowUnfreePackages = [ "obsidian" ];

    userHome = {
      home.packages = [ pkgs.obsidian ];
    };
  };
}
