{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    modules = {
      graphical = {
        obs = {
          enable = lib.mkEnableOption "Obs";
          amdSupport = lib.mkEnableOption "Enables AMD hardware acceleration";
          nvidiaSupport = lib.mkEnableOption "Enables Nvidia hardware acceleration";
        };
      };
    };
  };

  config = lib.mkIf config.modules.graphical.obs.enable {
    userHome = {
      programs.obs-studio = {
        enable = true;

        package = lib.mkIf config.modules.graphical.obs.nvidiaSupport (
          pkgs.obs-studio.override {
            cudaSupport = true;
          }
        );

        plugins =
          with pkgs.obs-studio-plugins;
          lib.mkMerge [
            (lib.mkIf config.modules.graphical.obs.amdSupport obs-vaapi)
            wlrobs
            obs-backgroundremoval
            obs-pipewire-audio-capture
            obs-gstreamer
            obs-vkcapture
          ];
      };
    };
  };
}
