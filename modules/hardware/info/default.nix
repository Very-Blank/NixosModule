{
  lib,
  config,
  mkModule,
  ...
}:
mkModule config [ "hardware" "info" ] {
  options = {
    battery = lib.mkEnableOption "True if the device has battery.";
  };
}
