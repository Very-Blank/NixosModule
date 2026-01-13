{
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    networking = {
      hostName = config.hostname;
      networkmanager.enable = true;

      hosts = let
        topLevelDomains = ["com" "ai" "net"];
        subdomains = ["chatgpt" "claude" "gemini.google" "perplexity" "deepseek" "cursor" "tiktok"];
      in {
        "0.0.0.0" = lib.mkMerge (map (domain: map (x: "${x}.${domain}") subdomains) topLevelDomains);
      };
    };

    # FIXME: move these:
    environment.systemPackages = lib.mkIf config.modules.graphical.bars.waybar.tray.enable [
      pkgs.libappindicator
      pkgs.networkmanagerapplet
    ];

    userHome = {
      systemd.user.services.nm-applet = lib.mkIf config.modules.graphical.bars.waybar.tray.enable {
        Unit = {
          Description = "Nm-applet service";
          PartOf = [
            "graphical-session.target"
            "dbus.socket"
          ];
          After = [
            "graphical-session.target"
            "dbus.socket"
          ];
        };
        Service = {
          ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
          Restart = "on-failure";
          RestartSec = "5s";
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };
    };
  };
}
