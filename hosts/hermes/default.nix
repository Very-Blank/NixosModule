{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  config = {
    hostname = "hermes";

    modules = {
      terminal = {
        tmux.enable = true;
        zsh.enable = true;
      };

      developer = {
        enable = true; # FIXME: this is bad
        ssh.keys = [
          {
            match = "github.com";
            hostname = "github.com";
            user = "very-blank";
          }

          {
            match = "taildevourer.com";
            hostname = "taildevourer.com";
            user = "blank";
          }
        ];
      };

      hardware = {
        audio.enable = true;
        bluetooth.enable = true;
        tuxedo.enable = true;
        backlight.enable = true;

        info = {
          battery = true;
        };
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
