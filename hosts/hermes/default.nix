{ ... }: {
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
        waybar = {
          enable = true;
          systemInfo = true;
          tray.enable = true;
        };

        environment.enable = true;
      };
    };
  };
}
