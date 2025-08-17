{lib, config, pkgs}: {
  options = {
    networking = {
      hostname = lib.mkOption {
        default = "nixos";
        description = "Hostname";
        type = lib.types.nonEmptyStr;
      };
    };
  };

  config = {
    networking = {
      hostName = config.networking.hostname;
      networkmanager.enable = true;
    };
  };
}
