{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    modules = {
      terminal = {
        zsh = {
          enable = lib.mkEnableOption "Enables the terminal zsh module";
        };
      };
    };
  };

  config = {
    programs.zsh = {
      enable = true;
    };

    modules.home.user.shell = {
      path = "${pkgs.zsh}/bin/zsh";
      package = pkgs.zsh;
    };

    # FIXME: This feels bad.
    modules.tty.greetd = {
      cmd = lib.mkOverride 100 config.modules.home.user.shell;
    };

    userHome = {
      home.packages = [pkgs.pure-prompt];

      programs.zsh = {
        enable = true;

        autosuggestion.enable = true;
        autosuggestion.highlight = "fg=#${config.scheme.base0E},bg=#${config.scheme.base01},bold,underline";

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
