{
  config,
  lib,
  ...
}: {
  options = {
    modules = {
      hardware = {
        tuxedo = {
          enable = lib.mkEnableOption "Enables the tuxedo module.";
        };
      };
    };
  };

  config = let
    cfg = config.modules.hardware.tuxedo;
  in
    lib.mkIf cfg.enable {
      hardware = {
        tuxedo-drivers.enable = true;

        tuxedo-rs = {
          enable = true;
          tailor-gui.enable = true;
        };
      };
    };
}
