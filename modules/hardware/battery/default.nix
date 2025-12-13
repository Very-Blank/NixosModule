{ lib, ... }:
{
  options = {
    modules = {
      hardware = {
        # FIXME: what is this?
        battery = {
          enable = lib.mkEnableOption "Battery";
        };
      };
    };
  };
}
