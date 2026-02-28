{
  lib,
  pkgs,
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
        home.packages = [pkgs.nextcloud-client];
      };
    };
}
