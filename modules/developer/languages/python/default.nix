{
  pkgs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "developer" "languages" "python" ] {
  config = {
    userHome = {
      home.packages = [
        pkgs.python3
      ];
    };
  };
}
