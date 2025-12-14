{
  pkgs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "developer" "languages" "rust" ] {
  config = {
    userHome = {
      home.packages = [
        pkgs.rustc
        pkgs.cargo
      ];
    };
  };
}
