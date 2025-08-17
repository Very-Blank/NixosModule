{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
  ];

  config = {
    boot = {
      grub.enable = false;
    };
  };
}
