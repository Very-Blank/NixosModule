{lib, config, ...}: {
  options = {
    modules = {
      hardware = {
        audio = {
          enable = lib.mkEnableOption "Enables audio.";
        };
      };
    };
  };

  config = lib.mkIf config.modules.hardware.audio.enable {
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
