{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../base.nix
  ];

  config = {
    modules = {
      networking = {
        hostname = "zeus";
      };

      terminal = {
        tmux.enable = true;
        zsh.enable = true;
      };

      developer.enable = true;
      hardware.audio.enable = true;

      graphical = {
        waybar = {
          enable = true;
          systemInfo.enable = true;
        };

        gaming.steam.enable = true;
        gaming.minecraft.enable = true;

        environment.enable = true;

        obs = {
          enable = true;
          amdSupport = true;
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

      boot = {
        multiboot.enable = true;
      };
    };
  };
}
