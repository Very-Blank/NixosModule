{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  config = {
    boot = {
      grub = false;
    };
  };
}
