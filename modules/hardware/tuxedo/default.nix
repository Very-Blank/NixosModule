{ config, lib, ... }: {
  options = {
    modules = {
      hardware = {
        tuxedo = {
          enable = lib.mkEnableOption "Enables tuxedo.";
        };
      };
    };
  };

  config = lib.mkIf config.modules.hardware.tuxedo.enable {
    hardware = {
      tuxedo-drivers.enable = true;

      tuxedo-rs = {
        enable = true;
        tailor-gui.enable = true;
      };
    };
  };
}
