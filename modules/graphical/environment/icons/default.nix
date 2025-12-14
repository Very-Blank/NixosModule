{
  pkgs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "graphical" "environment" "icons" ] {
  config = {
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
