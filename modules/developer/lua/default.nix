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
        lua = {
          enable = lib.mkEnableOption "Lua";
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.lua.enable {
    userHome = {
      home.packages = [
        pkgs.lua
        pkgs.lua-language-server
      ];
    };
  };
}
