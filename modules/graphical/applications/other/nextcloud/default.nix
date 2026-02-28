{
  lib,
  config,
  ...
}: {
  options = {
    modules = {
      graphical = {
        applications = {
          other = {
            nextcloud = {
              enable = lib.mkEnableOption "Enables the nextcloud-client module.";
            };
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.graphical.applications.other.nextcloud;
  in
    lib.mkIf cfg.enable {
      userHome = {
        services.nextcloud-client.enable = true;
      };
    };
}
