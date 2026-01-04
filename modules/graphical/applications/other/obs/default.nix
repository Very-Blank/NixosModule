{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    modules = {
      graphical = {
        applications = {
          other = {
            obs = {
              enable = lib.mkEnableOption "Enables the obs module.";

              hardwareAcceleration = lib.mkOption {
                default = "none";
                description = "The enabled hardware acceleration.";

                type = lib.types.enum [
                  "none"
                  "amd"
                  "nvidia"
                ];
              };
            };
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.graphical.applications.other.obs;
  in
    lib.mkIf cfg.enable {
      userHome = {
        programs.obs-studio = {
          enable = true;

          package = lib.mkIf (cfg.hardwareAcceleration == "nvidia") (
            pkgs.obs-studio.override {
              cudaSupport = true;
            }
          );

          plugins = with pkgs.obs-studio-plugins;
            lib.mkMerge [
              [(lib.mkIf (cfg.hardwareAcceleration == "amd") obs-vaapi)]
              [
                wlrobs
                obs-backgroundremoval
                obs-pipewire-audio-capture
                obs-gstreamer
                obs-vkcapture
              ]
            ];
        };
      };
    };
}
