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
          python = {
            enable = lib.mkEnableOption "Python";
          };
        };
      };
    };
  };

  config = lib.mkIf config.modules.developer.languages.python.enable {
    userHome = {
      home.packages = [
        pkgs.python3
      ];
    };
  };
}
