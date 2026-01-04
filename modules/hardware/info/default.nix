{lib, ...}: {
  options = {
    modules = {
      hardware = {
        info = {
          battery = lib.mkEnableOption "True if the device has battery.";
        };
      };
    };
  };
}
