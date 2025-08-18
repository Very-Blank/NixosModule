{lib, config, pkgs}: {
  options = {
    modules = {
      networking = {
        hostname = lib.mkOption {
          default = "nixos";
          description = "Hostname";
          type = lib.types.nonEmptyStr;
        };
      };
    };
  };

  config = {
    networking = {
      hostName = config.modules.networking.hostname;
      networkmanager.enable = true;
    };
  };
}
