{
  pkgs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "developer" "languages" "haskell" ] {
  config = {
    userHome = {
      home.packages = [
        pkgs.ghc
        pkgs.haskell-language-server
        pkgs.stack
      ];
    };
  };
}
