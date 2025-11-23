{ lib, config, ... }:
{
  options = {
    modules = {
      terminal = {
        tmux = {
          enable = lib.mkEnableOption "Tmux";
        };
      };
    };
  };

  config = lib.mkIf config.modules.terminal.tmux.enable {
    programs = {
      tmux = {
        enable = true;
        escapeTime = 0;
        keyMode = "vi";
        # FUCK YOU, https://github.com/nix-community/home-manager/issues/5952
        extraConfig = ''
          set -g default-command "$SHELL"
          set-option -g prefix C-a
          unbind C-b
          bind C-a send-prefix
        '';
      };
    };
  };
}
