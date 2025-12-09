{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
{

  options = {
    modules = {
      developer = {
        languages = {
          zig = {
            enable = lib.mkEnableOption "Zig";
          };
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.languages.zig.enable {
    userHome = {
      home.packages = [
        inputs.zig.packages.${pkgs.system}.default
        inputs.zls.packages.${pkgs.system}.default
      ];
    };
  };
}
