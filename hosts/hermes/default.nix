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

      graphical = {
        niri = {
          enable = true;
        };
      };

      hardware = {
        backlight.enable = true;
        tuxedo.enable = true;
      };
    };
  };
}
