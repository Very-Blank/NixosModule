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

      hardware = {
        backlight.enable = true;
        tuxedo.enable = true;
      };

      boot = {
        multiboot.enable = false;
      };
    };
  };
}
