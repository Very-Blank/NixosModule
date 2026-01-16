{
  lib,
  config,
  ...
}: {
  options = {
    modules = {
      graphical = {
        notifications = {
          mako = {
            enable = lib.mkEnableOption "Enables the mako notification daemon module.";
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.graphical.notifications.mako;
  in
    lib.mkIf cfg.enable {
      userHome = {
        services.mako = {
          enable = true;

          settings = let
            palette = config.colors.palette;
          in {
            default-timeout = 1500;
            border-radius = 10;
            border-size = 0;

            background-color = "#${palette.base00}FF";
            border-color = "#${palette.base0D}";
            text-color = "#${palette.base05}";
            progress-color = "over #${palette.base02}";

            "urgency=low" = {
              background-color = "#${palette.base00}FF";
              border-color = "#${palette.base03}";
              text-color = "#${palette.base05}";
            };

            "urgency=critical" = {
              background-color = "#${palette.base00}FF";
              border-color = "#${palette.base08}";
              text-color = "#${palette.base05}";
            };
          };
        };
      };
    };
}
