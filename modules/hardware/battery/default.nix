{lib, ...}:{
  options = {
    modules = {
      hardware = {
        battery = {
          enable = lib.mkEnableOption "Battery";
        };
      };
    };
  };
}
