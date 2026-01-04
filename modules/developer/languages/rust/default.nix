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
          rust = {
            enable = lib.mkEnableOption "Enables the rust language module.";
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.developer.languages.rust;
  in
    lib.mkIf cfg.enable {
      userHome = {
        home.packages = [
          pkgs.rustc
          pkgs.cargo
        ];
      };
    };
}
