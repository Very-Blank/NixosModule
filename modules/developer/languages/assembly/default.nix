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
          assembly = {
            enable = lib.mkEnableOption "Enables the assembly language module.";
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.developer.languages.assembly;
  in
    lib.mkIf cfg.enable {
      userHome = {
        home.packages = [
          pkgs.gdb
          pkgs.binutils
          pkgs.gnumake
          pkgs.gcc
        ];
      };
    };
}
