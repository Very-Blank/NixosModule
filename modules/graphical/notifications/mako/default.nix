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

          settings = {
            default-timeout = 1500;
            border-radius = 10;
            border-size = 0;

            background-color = "#${config.scheme.base00}FF";
            border-color = "#${config.scheme.base0D}";
            text-color = "#${config.scheme.base05}";
            progress-color = "over #${config.scheme.base02}";

            "urgency=low" = {
              background-color = "#${config.scheme.base00}FF";
              border-color = "#${config.scheme.base03}";
              text-color = "#${config.scheme.base05}";
            };

            "urgency=critical" = {
              background-color = "#${config.scheme.base00}FF";
              border-color = "#${config.scheme.base08}";
              text-color = "#${config.scheme.base05}";
            };
          };
        };
      };
    };
}
