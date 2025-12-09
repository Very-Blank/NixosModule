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
          haskell = {
            enable = lib.mkEnableOption "Haskell";
          };
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.languages.haskell.enable {
    userHome = {
      home.packages = [
        pkgs.ghc
        pkgs.haskell-language-server
        pkgs.stack
      ];
    };
  };
}
