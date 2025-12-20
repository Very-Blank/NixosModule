{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  config = {
    hostname = "ouroboros";

    modules = {
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
        openssh.enable = true;
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
