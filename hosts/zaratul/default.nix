{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  config = {
    hostname = "zaratul";

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
          {
            match = "gitlab.jyu.fi";
            hostname = "gitlab.jyu.fi";
            user = "aapotska";
          }
        ];
      };

      hardware.audio.enable = true;

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

          niri = {
            outputs = {
              "PNP(AOC) 2590G5 0x00002709" = {
                mode = {
                  width = 1920;
                  height = 1080;
                  refresh = 74.973;
                };

                position = {
                  x = 1920;
                  y = 0;
                };
              };

              "Samsung Electric Company LS32AG32x H9JT200575   " = {
                mode = {
                  width = 1920;
                  height = 1080;
                  refresh = 164.955;
                };

                focus-at-startup = true;
                position = {
                  x = 0;
                  y = 0;
                };
              };
            };
          };
        };

        applications.other.obs = {
          amdSupport = true;
        };
      };

      boot = {
        multiboot.enable = true;
      };
    };
  };
}
