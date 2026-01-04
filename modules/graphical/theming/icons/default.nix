{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    modules = {
      graphical = {
        theming = {
          icons = {
            enable = lib.mkEnableOption "Enables the icons module.";
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.graphical.theming.icons;
  in
    lib.mkIf cfg.enable {
      userHome = {
        gtk = {
          enable = true;
          iconTheme = {
            name = "Papirus";
            package = pkgs.papirus-icon-theme;
          };
        };
      };
    };
}
