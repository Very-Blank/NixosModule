{ config, lib, ... }: {
  options = {
    boot = {
      grub = {
        enable = lib.mkEnableOption "Enables grub, if disabled uses systemd-boot.";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.boot.grub.enable {
      boot.loader.systemd-boot.enable = false;
      boot.loader.grub.enable = true;
      boot.loader.grub.device = "nodev";
      boot.loader.grub.useOSProber = true;
      boot.loader.grub.efiSupport = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.efi.efiSysMountPoint = "/boot";
    })
    (lib.mkIf (!config.boot.grub.enable) {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
    })
  ];
}
