{lib, config, pkgs, ...}: {
  options = {
    modules = {
      tty = {
        getty = {
          enable = lib.mkEnableOption "Getty";

          displayManager = {
            enable = lib.mkEnableOption "TTY1 autologin";
            command = lib.mkOption {
              type = lib.types.nonEmptyStr;
              description = "Command that is autostarted on TTY1";
            };
          };
        };
      };
    };
  };

  config = lib.mkIf config.modules.tty.getty {
    systemd.services."autovt@tty1".description = "Autologin at the TTY1";
    systemd.services."autovt@tty1".after = [ "systemd-logind.service" ];
    systemd.services."autovt@tty1".wantedBy = [ "multi-user.target" ];
    systemd.services."autovt@tty1".serviceConfig = {
      ExecStart = [
        ""  # override upstream default with an empty ExecStart
        "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${pkgs.writeShellScript "login-with-niri" ''
          ${pkgs.shadow}/bin/login guest
          exec ${pkgs.niri}/bin/niri-session
        ''} --autologin ${config.modules.home.user.name} --noclear %I $TERM"
      ];
      Restart = "always";
      Type = "idle";
    };
  };
}
