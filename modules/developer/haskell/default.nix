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
        pkgs.haskellPackages.haskell-lsp-types
        pkgs.stack
      ];
    };
  };
}
