{
  lib,
  config,
  pkgs,
  ...
}:
{

  options = {
    modules = {
      developer = {
        languages = {
          rust = {
            enable = lib.mkEnableOption "Rust";
          };
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.languages.rust.enable {
    userHome = {
      home.packages = [
        pkgs.rustc
        pkgs.cargo
      ];
    };
  };
}
