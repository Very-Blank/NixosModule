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
          asm = {
            enable = lib.mkEnableOption "Asm";
          };
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.languages.asm.enable {
    userHome = {
      home.packages = [
        pkgs.asm-lsp
        pkgs.binutils
        pkgs.gnumake
        pkgs.gcc
      ];
    };
  };
}
