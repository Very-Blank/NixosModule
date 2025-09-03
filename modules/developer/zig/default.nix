{lib, config, inputs, pkgs, ...}: {

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
    nixpkgs.overlays = [ inputs.zig.overlays.default ];
    userHome = {
      home.packages = [
        pkgs.zig
      ];
    };
  };
}
