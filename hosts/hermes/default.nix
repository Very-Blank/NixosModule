{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../base.nix
  ];

  config = {
    modules = {
      networking = {
        hostname = "hermes";
      };

      terminal = {
        tmux.enable = true;
        zsh.enable = true;
      };

      developer.enable = true;

      hardware = {
        audio.enable = true;
        bluetooth.enable = true;
        battery.enable = true;
        tuxedo.enable = true;
        backlight.enable = true;
      };

      graphical = {
        environment = {
          enable = true;
          windowManager = "niri";

          applications = [
            "steam"
            "obsidian"
            "obs"
          ];

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
