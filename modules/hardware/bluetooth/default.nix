{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    modules = {
      hardware = {
        bluetooth = {
          enable = lib.mkEnableOption "Enables bluetooth.";
        };
      };
    };
  };

  config = lib.mkIf config.modules.hardware.bluetooth.enable {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    };

    services = lib.mkIf config.modules.graphical.waybar.tray.enable {
      blueman.enable = true;
    };

    # FIXME: Move these.

    userHome = {
      systemd.user.services.blueman-applet = lib.mkIf config.modules.graphical.waybar.tray.enable {
        Unit = {
          Description = "Blueman-applet service";
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
          ExecStart = "${pkgs.blueman}/bin/blueman-applet";
          Restart = "on-failure";
          RestartSec = "5s";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
  };
}
