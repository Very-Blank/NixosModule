{
  pkgs,
  lib,
  config,
  mkIfModule,
  ...
}:
mkIfModule config ["hardware" "bluetooth"] {
  config = {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    };

    services = lib.mkIf config.modules.graphical.bars.waybar.tray.enable {
      blueman.enable = true;
    };

    # FIXME: Move these.

    userHome = {
      systemd.user.services.blueman-applet =
        lib.mkIf config.modules.graphical.bars.waybar.tray.enable
        {
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
            WantedBy = ["graphical-session.target"];
          };
        };
    };
  };
}
