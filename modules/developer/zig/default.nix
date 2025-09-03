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
    userHome = {
      home.packages = [
        inputs.zig.packages.${pkgs.system}.default
      ];
    };
  };
}
