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
        haskell = {
          enable = lib.mkEnableOption "Haskell";
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.haskell.enable {
    userHome = {
      home.packages = [
        pkgs.haskell-language-server
        pkgs.stack
      ];
    };
  };
}
