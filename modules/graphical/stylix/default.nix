{lib, config, pkgs, ...}: {
  options = {
    modules = {
      graphical = {
        stylix = {
          enable = lib.mkEnableOption "Stylix";
        };
      };
    };
  };

  config = lib.mkIf config.modules.graphical.stylix.enable {
    userHome = {
      stylix = {
        enable = true;
        autoEnable = false;

        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
        targets = {
          firefox = {
            enable = config.modules.graphical.firefox.enable;
            profileNames = [ config.modules.home.user.name ];
          };

          fuzzel.enable = config.modules.graphical.fuzzel.enable;
          ghostty.enable = config.modules.terminal.ghostty.enable;
          mako.enable = config.modules.graphical.mako.enable;
        };

        fonts = {
          serif = {
            package = pkgs.dejavu_fonts;
            name = "DejaVu Serif";
          };

          sansSerif = {
            package = pkgs.dejavu_fonts;
            name = "DejaVu Sans";
          };

          monospace = {
            package =  pkgs.nerd-fonts._0xproto;
            name = "0xProto Nerd Font";
          };

          emoji = {
            package = pkgs.noto-fonts-emoji;
            name = "Noto Color Emoji";
          };
        };
      };
    };
  };
}
