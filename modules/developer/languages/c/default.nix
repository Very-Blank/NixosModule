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
          c = {
            enable = lib.mkEnableOption "C";
          };
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.languages.c.enable {
    userHome = {
      home.packages = [
        pkgs.gnumake
        pkgs.cmake
        pkgs.clang-tools
        pkgs.gcc
      ];
    };
  };
}
