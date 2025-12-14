{
  pkgs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "developer" "languages" "lua" ] {
  config = {
    userHome = {
      home.packages = [
        pkgs.lua
        pkgs.lua-language-server
      ];
    };
  };
}
