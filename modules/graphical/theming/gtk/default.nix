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
          gtk = {
            enable = lib.mkEnableOption "Enables the gtk module.";
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.graphical.theming.gtk;
  in
    lib.mkIf cfg.enable {
      programs.dconf.enable = true;

      userHome = {
        gtk.theme = {
          package = pkgs.adw-gtk3;
          name = "adw-gtk3";
        };

        xdg.configFile = {
          "gtk-3.0/gtk.css".source = finalCss;
          "gtk-4.0/gtk.css".source = finalCss;
        };
      };
    };
}
