{
  pkgs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config ["graphical" "theming" "icons"] {
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
