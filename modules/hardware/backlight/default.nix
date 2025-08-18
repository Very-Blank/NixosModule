{ config, lib, ... }: {
  options = {
    modules = {
      hardware = {
        backlight = {
          enable = lib.mkEnableOption "Enables backlight for screens.";
        };
      };
    };
  };

  config = lib.mkIf config.modules.hardware.backlight.enable {
    programs = {
      light = {
        enable = true;
      };
    };

    services = {
      actkbd = {
        enable = true;
        bindings = [
          { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 5"; }
          { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 5"; }
        ];
      };
    };
  };
}
