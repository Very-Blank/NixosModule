{lib, config, pkgs, ...}:

{
  options = {
    modules = {
      graphical = {
        fuzzel = {
          enable = lib.mkEnableOption "Fuzzel";
        };
      };
    };
  };

  config = lib.mkIf config.modules.graphical.fuzzel.enable {
    fonts = {
      packages = [
        pkgs.nerd-fonts._0xproto
      ];
    };

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

      gtk = {
        enable = true;
        iconTheme = {
          name = "Papirus";
          package = pkgs.papirus-icon-theme;
        };
      };
    };
  };
}
