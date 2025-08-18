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

  config = lib.mkIf config.modules.tty.getty.enable {
    services.logind.extraConfig = ''
      NAutoVTs=7
    '';

    # Start getty on TTY1 right away

    # Alternative approach: Use a custom login program
    # Uncomment this section if you prefer this method instead of the shell approach above
    systemd.services."getty@tty1" = {
      overrideStrategy = "asDropin";
      serviceConfig = {
        ExecStartPre = [
          "${pkgs.kbd}/bin/chvt 1"
        ];
        ExecStart = [
          ""
          "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${pkgs.writeShellScript "niri-login" ''
            ${pkgs.shadow}/bin/login "$@"
            if [ "$USER" = "${config.modules.home.user.name}" ] && [ "$(tty)" = "/dev/tty1" ]; then
              exec niri-session
            fi
          ''} --autologin ${config.modules.home.user.name} --noclear %I $TERM"
        ];
      };
    };

    systemd.targets."getty".wants = [ "getty@tty1.service" ];
  };
}
