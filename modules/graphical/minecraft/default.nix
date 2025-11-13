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
        minecraft = {
          enable = lib.mkEnableOption "Minecraft";
        };
      };
    };
  };

  config = lib.mkIf config.modules.graphical.minecraft.enable {
    config = {
      userHome = {
        home.packages = [
          pkgs.prismlauncher
        ];
      };
    };
  };
}
