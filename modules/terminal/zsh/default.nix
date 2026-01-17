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
    modules.home.user.shell = {
      path = "${pkgs.zsh}/bin/zsh";
      package = pkgs.zsh;
    };

    # FIXME: This feels bad.
    modules.tty.greetd = {
      cmd = lib.mkOverride 100 config.modules.home.user.shell;
    };

    programs.zsh = {
      enable = true;
    };

    environment.pathsToLink = ["/share/zsh"]; # For completions to work

    userHome = {
      home.packages = [pkgs.pure-prompt];

      programs.zsh = {
        enable = true;

        enableCompletion = true;
        autosuggestion.enable = true;
        # FIXME: This causes buggy behaviour: <https://github.com/zsh-users/zsh-autosuggestions/issues/698>
        #        Raise this as an issue to home-manager.
        # autosuggestion.highlight = let palette = config.colors.palette; in "fg=#${palette.base0E},bg=#${palette.base01},bold,underline";
        autosuggestion.highlight = let palette = config.colors.palette; in "fg=#${palette.base0E},bg=#${palette.base01},bold";
        syntaxHighlighting.enable = true;

        defaultKeymap = "viins";

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

          bindkey '^Y' autosuggest-accept
        '';
      };
    };
  };
}
