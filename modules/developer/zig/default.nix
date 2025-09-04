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
        inputs.zig.packages.${pkgs.system}.zig-src-latest
        (inputs.zls.packages.${pkgs.system}.zls.overrideAttrs (old: {
            nativeBuildInputs = [ inputs.zig.packages.${pkgs.system}.zig-src-latest ];
        }))
      ];
    };
  };
}
