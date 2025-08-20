{lib, config, pkgs, ...}: {
  options = {
    modules = {
      networking = {
        hostname = lib.mkOption {
          default = "nixos";
          description = "Hostname";
          type = lib.types.nonEmptyStr;
        };
      };
    };
  };

  config = {
    networking = {
      hostName = config.modules.networking.hostname;
      networkmanager.enable = true;
    };

    services = {
      openssh.enable = true;
    };

    environment.systemPackages = lib.mkIf config.modules.graphical.waybar.tray.enable [
      pkgs.libappindicator
      pkgs.networkmanagerapplet
    ];

    userHome = {
      systemd.user.services.nm-applet = lib.mkIf config.modules.graphical.waybar.tray.enable {
        Unit = {
          Description = "Nm-applet service";
          PartOf = [ "graphical-session.target"  "dbus.socket" ];
          After = [ "graphical-session.target"  "dbus.socket" ];
        };
        Service = {
          ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
          Restart     = "on-failure";
          RestartSec  = "5s";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };

    };
  };
}
