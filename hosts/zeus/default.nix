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

      terminal.zsh.enable = true;

      graphical = {
        niri = {
          enable = false;
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
