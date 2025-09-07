{ ... }: {
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

        gaming.enable = true;

        environment.enable = true;

        niri = {
          outputs = {
            "PNP(AOC) 2590G5 0x00002709" = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 74.973;
              };
            };

            "Samsung Electric Company LS32AG32x H9JT200575   " = {
              mode = {
                width = 1920;
                height = 1080;
                refresh = 164.955;
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
