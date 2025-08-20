{pkgs, config, lib, ...}: {
  options = {
    modules = {
      terminal = {
        ghostty = {
          enable = lib.mkEnableOption "Ghostty";

          font = {
            enable = lib.mkEnableOption "Terminal font";
            package = lib.mkPackageOption pkgs "Font package" {
              default = [ "nerd-fonts" "_0xproto" ];
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

  config = lib.mkIf config.modules.terminal.ghostty.enable {
    fonts = {
      packages = [
        config.modules.terminal.ghostty.font.package
      ];
    };

    userHome = {
      programs.ghostty = {
        enable = true;
        settings = {
          font-family = config.modules.terminal.ghostty.font.family;
          title = "Ghostty";
          adjust-cell-width = "-10%";
          adjust-cell-height = "-10%";
        };
      };
    };

  };
}
