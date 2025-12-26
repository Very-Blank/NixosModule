{
  pkgs,
  lib,
  config,
  mkIfModule,
  ...
}:
mkIfModule config ["graphical" "terminalEmulators" "ghostty"] {
  options = {
    font = {
      enable = lib.mkEnableOption "Terminal font";
      package = lib.mkPackageOption pkgs "Font package" {
        default = [
          "nerd-fonts"
          "_0xproto"
        ];
      };

      family = lib.mkOption {
        default = "0xProto Nerd Font Mono";
        description = "Name of the mono font";
        type = lib.types.nonEmptyStr;
      };
    };
  };

  config = cfg: {
    fonts = {
      packages = [
        cfg.font.package
      ];
    };

    userHome = {
      programs.ghostty = {
        enable = true;
        settings = {
          font-family = cfg.font.family;
          title = "Ghostty";
          adjust-cell-width = "-10%";
          adjust-cell-height = "-10%";

          theme = "custom";
        };

        themes.custom = {
          background = config.scheme.base00;
          foreground = config.scheme.base0B;

          cursor-color = config.scheme.base05;
          selection-background = config.scheme.base01;
          selection-foreground = config.scheme.base05;

          palette = with config.scheme; [
            "0=#${base00}"
            "1=#${base08}"
            "2=#${base0B}"
            "3=#${base0A}"
            "4=#${base0D}"
            "5=#${base0E}"
            "6=#${base0C}"
            "7=#${base05}"
            "8=#${base03}"
            "9=#${base08}"
            "10=#${base0B}"
            "11=#${base0A}"
            "12=#${base0D}"
            "13=#${base0E}"
            "14=#${base0C}"
            "15=#${base07}"
          ];
        };
      };
    };
  };
}
