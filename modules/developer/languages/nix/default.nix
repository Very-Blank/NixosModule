{
  pkgs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "developer" "languages" "nix" ] {
  config = {
    userHome = {
      home.packages = [
        pkgs.nil
      ];
    };
  };
}
