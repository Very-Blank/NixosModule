{
  lib,
  config,
  ...
}: {
  options = {
    modules = {
      graphical = {
        launchers = {
          vicinae = {
            enable = lib.mkEnableOption "Enables the vicinae launcher module.";
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.graphical.launchers.vicinae;
  in
    lib.mkIf cfg.enable {
      userHome = {
        programs.vicinae = {
          enable = true;
          settings.theme.name = "theme";

          themes.theme = {
            meta = {
              name = "theme";
              variant = "dark";
              description = "My base16 theme.";
            };

            colors = {
              core = {
                background = "#${config.scheme.base00}";
                foreground = "#${config.scheme.base05}";
                secondary_background = "#${config.scheme.base01}";
                border = "#${config.scheme.base02}";
                accent = "#${config.scheme.base0D}";
              };

              accents = {
                blue = "#${config.scheme.base0D}";
                green = "#${config.scheme.base0B}";
                magenta = "#${config.scheme.base0E}";
                orange = "#${config.scheme.base09}";
                purple = "#${config.scheme.base0E}";
                red = "#${config.scheme.base08}";
                yellow = "#${config.scheme.base0A}";
                cyan = "#${config.scheme.base0C}";
              };

              list.item = {
                selection = {
                  background.name = "#${config.scheme.base02}";
                  secondary_background = "#${config.scheme.base03}";
                };

                hover.background = "#${config.scheme.base01}";
              };
            };
          };
        };
      };
    };
}
