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
            steam = {
              enable = lib.mkEnableOption "Enables the steam module.";
            };
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.graphical.applications.other.steam;
  in
    lib.mkIf cfg.enable {
      modules.unfreePackages = [
        "steam"
        "steam-original"
        "steam-unwrapped"
        "steam-run"
      ];

      programs.steam = {
        enable = true;
      };
    };
}
