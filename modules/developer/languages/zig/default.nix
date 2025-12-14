{
  pkgs,
  inputs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "developer" "languages" "zig" ] {
  config = {
    userHome = {
      home.packages = [
        inputs.zig.packages.${pkgs.system}.default
        inputs.zls.packages.${pkgs.system}.default
      ];
    };
  };
}
