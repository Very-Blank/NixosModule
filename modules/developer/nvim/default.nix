{inputs, pkgs, lib, ... }: {
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
        pkgs.lua-language-server
        inputs.zls.packages.${pkgs.system}.default
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
