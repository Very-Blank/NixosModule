{ config, lib, ... }: {
  options = {
    modules = {
      boot = {
        multiboot = {
          enable = lib.mkEnableOption "Enables grub, if disabled uses systemd-boot.";
        };
      };
    };
  };

  config = lib.mkMerge [ (lib.mkMerge [
    (lib.mkIf config.modules.boot.multiboot.enable {
      boot.loader.grub.enable = true;
      boot.loader.grub.device = "nodev";
      boot.loader.grub.useOSProber = true;
      boot.loader.grub.efiSupport = true;

      boot.loader.efi.efiSysMountPoint = "/boot";

    })
    (lib.mkIf (!config.modules.boot.multiboot.enable) {
      boot.loader.systemd-boot.enable = true;
    })])
    {
      boot.consoleLogLevel = 3;
      boot.loader.efi.canTouchEfiVariables = true;
    }
  ];
}
