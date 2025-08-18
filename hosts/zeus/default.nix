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

      boot = {
        multiboot.enable = true;
      };
    };
  };
}
