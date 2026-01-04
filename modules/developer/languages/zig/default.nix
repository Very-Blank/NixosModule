{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  options = {
    modules = {
      developer = {
        languages = {
          zig = {
            enable = lib.mkEnableOption "Enables the zig language module.";
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.developer.languages.zig;
  in
    lib.mkIf cfg.enable {
      userHome = {
        home.packages = [
          inputs.zig.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
      };
    };
}
