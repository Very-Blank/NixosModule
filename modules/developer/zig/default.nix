{lib, config, pkgs, inputs, ...}: {
  imports = [
    inputs.zig.nixosModules.zig
  ];

  options = {
    modules = {
      developer = {
        zig = {
          enable = lib.mkEnableOption "Zig";
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.zig.enable {
    userHome = {
      home.packages = [
        pkgs.cmake
        pkgs.rustc
        pkgs.cargo
        pkgs.gcc
        pkgs.python3
        pkgs.gnumake
      ];
    };
  };
}
