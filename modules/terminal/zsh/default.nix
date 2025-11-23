{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    modules = {
      terminal = {
        zsh = {
          enable = lib.mkEnableOption "Zsh";
        };
      };
    };
  };

  config = lib.mkIf config.modules.terminal.zsh.enable {
    programs.zsh = {
      enable = true;
    };

    modules.home.user.shell = {
      path = "${pkgs.zsh}/bin/zsh";
      package = pkgs.zsh;
    };

    modules.tty.greetd = {
      cmd = lib.mkOverride 100 config.modules.home.user.shell;
    };

    userHome = {
      home.packages = [ pkgs.pure-prompt ];

      programs.zsh = {
        enable = true;

        autosuggestion.enable = true;
        autosuggestion.highlight = lib.mkMerge [
          (lib.mkIf config.modules.graphical.stylix.enable "fg=#383838,bg=#a1d8fc,bold,underline")
          (lib.mkIf (
            !config.modules.graphical.stylix.enable
          ) "fg=#${config.lib.stylix.colors.base0D},bg=#${config.lib.stylix.colors.base0B},bold,underline")
        ];

        syntaxHighlighting.enable = true;

        shellAliases = {
          ns = "nix-shell --run zsh";

          ls = "ls --color=auto -h --group-directories-first";
          ll = "ls -l";
          rr = "rm -r";

          gca = "git commit -a";
          gc = "git checkout";
          grm = "git rebase main";
          gcb = "git checkout -b";
          gsm = "git push origin main";
          glm = "git pull origin main";

          hibernate = "systemctl hibernate";
        };

        history.size = 10000;

        initContent = ''
          fpath+=(${pkgs.pure-prompt}/share/zsh/site-functions)
          autoload -U promptinit && promptinit
          prompt pure

          bindkey -v
          bindkey -M vicmd ':' vi-cmd-mode
          bindkey "^H" backward-delete-char
          bindkey "^?" backward-delete-char
          bindkey '^Y' autosuggest-accept
        '';
      };
    };
  };
}
