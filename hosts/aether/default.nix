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

      developer.nvim.enable = true;

      hardware = {
        backlight.enable = true;

        info = {
          battery = true;
        };
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
