{lib, config, pkgs,...}: {
  options = {
    modules = {
      graphical = {
        icons = {
          enable = lib.mkEnableOption "Icons";
        };
      };
    };
  };

  config = lib.mkIf config.modules.graphical.icons.enable {
    userHome = {
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
