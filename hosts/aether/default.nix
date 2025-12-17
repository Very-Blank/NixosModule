{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../base.nix
  ];

  config = {
    modules = {
      networking = {
        hostname = "aether";
      };

      terminal = {
        tmux.enable = true;
        zsh.enable = true;
      };

      developer.enable = true;

      hardware = {
        backlight.enable = true;
        audio.enable = true;

        info = {
          battery = true;
        };
      };

      server = {
        tailscale.enable = true;
        tailscale.domain = "tailf09877.ts.net";
        openssh.enable = true;
        vaultwarden.enable = true;
        nginx.enable = true;
      };

      graphical = {
        environment = {
          enable = true;
          windowManager = "niri";

          waybar = {
            enable = true;
            systemInfo.enable = true;
            tray.enable = true;
          };
        };
      };
    };
  };
}
