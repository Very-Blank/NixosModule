{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  options = {
    modules = {
      developer = {
        nvim = {
          enable = lib.mkEnableOption "Nvim";
        };
      };
    };
  };

  config = {
    userHome = {
      # Language servers
      home.packages = [
      ];

      programs.neovim = {
        enable = true;
        defaultEditor = true;
      };

      xdg.configFile."nvim" = {
        enable = true;
        source = inputs.nvim;
      };
    };
  };
}
