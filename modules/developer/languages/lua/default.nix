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
          lua = {
            enable = lib.mkEnableOption "Lua";
          };
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.languages.lua.enable {
    userHome = {
      home.packages = [
        pkgs.lua
        pkgs.lua-language-server
      ];
    };
  };
}
