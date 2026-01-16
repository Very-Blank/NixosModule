{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    modules = {
      graphical = {
        terminalEmulators = {
          ghostty = {
            enable = lib.mkEnableOption "Enables the ghostty terminal emulator module.";

            # FIXME: REMOVE
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
        };
      };
    };
  };

  config = let
    cfg = config.modules.graphical.terminalEmulators.ghostty;
  in
    lib.mkIf cfg.enable {
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

          themes.custom = let
            palette = config.colors.palette;
          in {
            background = palette.base00;
            foreground = palette.base0B;

            cursor-color = palette.base05;
            selection-background = palette.base01;
            selection-foreground = palette.base05;

            palette = with palette; [
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
