{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
  ];

  config = {
    modules = {
      networking = {
        hostname = "zeus";
      };

      boot = {
        multiboot.enable = true;
      };
    };
  };
}
