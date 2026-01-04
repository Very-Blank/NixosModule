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
          defaultEditor = lib.mkEnableOption "Whether to enable nvim as the default editor.";

          languages = lib.mkOption {
            default = [];
            description = "Languages to be enabled.";
            type = with lib.types;
              listOf (enum [
                "nix"
                "haskell"
                "rust"
                "zig"
                "python"
                "assembly"
                "c"
                "cpp"
              ]);
          };
        };
      };
    };
  };

  config = let
    cfg = config.modules.developer.nvim;
  in
    lib.mkIf cfg.enable {
      environment.systemPackages = [
        (inputs.nixnvim.packages.${pkgs.stdenv.system}.default.override {
          theme = {
            base00 = config.scheme.base00;
            base01 = config.scheme.base01;
            base02 = config.scheme.base02;
            base03 = config.scheme.base03;
            base04 = config.scheme.base04;
            base05 = config.scheme.base05;
            base06 = config.scheme.base06;
            base07 = config.scheme.base07;
            base08 = config.scheme.base08;
            base09 = config.scheme.base09;
            base0A = config.scheme.base0A;
            base0B = config.scheme.base0B;
            base0C = config.scheme.base0C;
            base0D = config.scheme.base0D;
            base0E = config.scheme.base0E;
            base0F = config.scheme.base0F;
          };

          languages = cfg.languages;
        })
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
