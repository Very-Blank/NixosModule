{
  lib,
  pkgs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config ["graphical" "launchers" "fuzzel"] {
  config = {
    fonts = {
      packages = [
        pkgs.nerd-fonts._0xproto
      ];
    };

    modules.graphical.theming.icons.enable = true;

    userHome = {
      programs.fuzzel = {
        enable = true;
        settings = {
          main = {
            icon-theme = "Papirus";
            width = 40;
            font = lib.mkForce "0xProtoNerdFont:weight=normal:size=14";
            line-height = 15;
            vertical-pad = 8;
            horizontal-pad = 20;
            prompt = "\"❯ \"";
            exit-on-keyboard-focus-loss = "yes";
          };

          border = {
            radius = 20;
          };

          dmenu = {
            exit-immediately-if-empty = "yes";
          };
        };
      };
    };
  };
}
