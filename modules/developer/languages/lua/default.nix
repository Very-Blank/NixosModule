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
          lua = {
            enable = lib.mkEnableOption "Enable the lua language module.";
          };
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.languages.lua.enable {
    userHome = {
      home.packages = [
        pkgs.lua
      ];
    };
  };
}
