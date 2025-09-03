{lib, config, inputs, ...}: {
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
      programs.zig.enable = true;
    };
  };
}
