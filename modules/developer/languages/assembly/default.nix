{
  pkgs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "developer" "languages" "asm" ] {
  config = {
    userHome = {
      home.packages = [
        pkgs.asm-lsp
        pkgs.gdb
        pkgs.binutils
        pkgs.gnumake
        pkgs.gcc
      ];
    };
  };
}
