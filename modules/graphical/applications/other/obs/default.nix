{
  lib,
  config,
  pkgs,
  mkIfModule,
  ...
}:
mkIfModule config [ "graphical" "applications" "other" "obs" ] {
  options = {
    amdSupport = lib.mkEnableOption "Enables AMD hardware acceleration";
    nvidiaSupport = lib.mkEnableOption "Enables Nvidia hardware acceleration";
  };

  config = cfg: {
    userHome = {
      programs.obs-studio = {
        enable = true;

        package = lib.mkIf cfg.nvidiaSupport (
          pkgs.obs-studio.override {
            cudaSupport = true;
          }
        );

        plugins =
          with pkgs.obs-studio-plugins;
          lib.mkMerge [
            [ (lib.mkIf cfg.amdSupport obs-vaapi) ]
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
