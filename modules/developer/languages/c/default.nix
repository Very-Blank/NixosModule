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
          c = {
            enable = lib.mkEnableOption "Enables the c language module.";
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.developer.languages.c;
  in
    lib.mkIf cfg.enable {
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
