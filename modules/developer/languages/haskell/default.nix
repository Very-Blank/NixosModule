{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    modules = {
      developer = {
        languages = {
          haskell = {
            enable = lib.mkEnableOption "Enable the haskell language module.";
          };
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.languages.haskell.enable {
    userHome = {
      home.packages = [
        pkgs.ghc
        pkgs.stack
      ];
    };
  };
}
