{
  lib,
  config,
  ...
}: {
  options = {
    modules = {
      hardware = {
        audio = {
          enable = lib.mkEnableOption "Enables the audio module.";
        };
      };
    };
  };

  config = let
    cfg = config.modules.hardware.audio;
  in
    lib.mkIf cfg.enable {
      services = {
        pipewire = {
          enable = true;
          pulse.enable = true;
          audio.enable = true;

          alsa = {
            enable = true;
            support32Bit = true;
          };

          jack.enable = true;
        };
      };
    };
}
