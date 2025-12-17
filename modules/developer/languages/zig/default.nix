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
        inputs.zig.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.zls.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };
  };
}
