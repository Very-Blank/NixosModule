{
  pkgs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "developer" "languages" "c" ] {
  config = {
    userHome = {
      home.packages = [
        pkgs.gnumake
        pkgs.cmake
        pkgs.clang-tools
        pkgs.gcc
      ];
    };
  };
}
