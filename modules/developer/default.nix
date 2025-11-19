{ config, lib, ... }:
{
  imports = [
    ./git
    ./nvim
    ./tooling
    ./zig
    ./haskell
  ];

  options = {
    modules = {
      developer = {
        enable = lib.mkEnableOption "Enables basic developer tools";
      };
    };
  };

  config = lib.mkIf config.modules.developer.enable {
    modules.developer.lua.enable = true;
    modules.developer.haskell.enable = true;
    modules.developer.zig.enable = true;
    modules.developer.nvim.enable = true;
    modules.developer.git.enable = true;
    modules.developer.tooling.enable = true;
  };
}
