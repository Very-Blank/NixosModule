{
  pkgs,
  lib,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "terminal" "ghostty" ] {
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

  config = {
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
