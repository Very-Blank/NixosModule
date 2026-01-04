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
            obsidian = {
              enable = lib.mkEnableOption "Enables the obsidian module.";
            };
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.graphical.applications.other.obsidian;
  in
    lib.mkIf cfg.enable {
      modules.unfreePackages = [
        "obsidian"
      ];

      userHome = {
        home.packages = [pkgs.obsidian];
      };
    };
}
