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
          python = {
            enable = lib.mkEnableOption "Enables the python language module.";
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.developer.languages.python;
  in
    lib.mkIf cfg.enable {
      userHome = {
        home.packages = [
          pkgs.python3
        ];
      };
    };
}
