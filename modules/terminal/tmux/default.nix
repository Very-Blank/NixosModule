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
        # FUCK YOU, https://github.com/tmux/tmux/issues/4240
        extraConfig = ''
          set-option -g prefix C-a
          unbind C-b
          bind C-a send-prefix

          set -gu default-command
          set -g default-shell "$SHELL"
        '';
      };
    };
  };
}
