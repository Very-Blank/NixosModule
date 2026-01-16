{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: {
  options = {
    modules = {
      developer = {
        nvim = {
          enable = lib.mkEnableOption "Enables the nvim module.";
          defaultEditor = lib.mkEnableOption "Whether to enable nvim as the default editor.";
        };
      };
    };
  };

  config = let
    cfg = config.modules.developer.nvim;
  in
    lib.mkIf cfg.enable {
      environment.systemPackages = [
        inputs.nixnvim.packages.${pkgs.stdenv.system}.default
      ];

      userHome = lib.mkIf cfg.defaultEditor {
        home.sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
          SUDO_EDITOR = "nvim";
        };

        programs.git = {
          settings = {
            core.editor = "nvim";
          };
        };

        programs.bash = {
          bashrcExtra = ''
            export EDITOR="nvim"
            export VISUAL="nvim"
          '';
        };

        programs.zsh = {
          initContent = ''
            export EDITOR="nvim"
            export VISUAL="nvim"
          '';
        };
      };
    };
}
