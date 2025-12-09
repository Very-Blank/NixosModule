{
  lib,
  config,
  pkgs,
  ...
}:
{

  options = {
    modules = {
      developer = {
        languages = {
          nix = {
            enable = lib.mkEnableOption "Nix";
          };
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.languages.nix.enable {
    userHome = {
      home.packages = [
        pkgs.nil
      ];
    };
  };
}
