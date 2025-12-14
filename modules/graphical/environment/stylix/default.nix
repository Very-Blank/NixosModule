{
  pkgs,
  inputs,
  config,
  mkIfModule,
  ...
}:
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
}
// mkIfModule config [ "graphical" "environment" "stylix" ] {
  config = {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

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
          package = pkgs.nerd-fonts._0xproto;
          name = "0xProto Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
    };

    userHome = {
      stylix = {
        enable = true;
        polarity = "dark";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

        targets = {
          firefox = {
            enable = config.modules.graphical.applications.browsers.firefox.enable;
            profileNames = [ config.modules.home.user.name ];
          };

          fuzzel.enable = config.modules.graphical.environment.fuzzel.enable;
          ghostty.enable = config.modules.terminal.ghostty.enable;
          mako.enable = config.modules.graphical.environment.mako.enable;
          waybar.enable = false;
          neovim.enable = false;
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
            package = pkgs.nerd-fonts._0xproto;
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
