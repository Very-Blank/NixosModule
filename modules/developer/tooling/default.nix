{lib, pkgs, config, ...}: {
  options = {
    modules = {
      developer = {
        tooling = {
          enable = lib.mkEnableOption "tooling";
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.tooling.enable {
    userHome = {
      home.packages = [
        pkgs.cmake
        pkgs.zig
        pkgs.rustc
        pkgs.cargo
        pkgs.gcc
        pkgs.python3
        pkgs.gnumake
      ];
    };
  };
}
