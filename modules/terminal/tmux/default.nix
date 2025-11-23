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
        extraConfig = ''
          set-option -g default-shell ${config.users.users.${config.modules.home.user.name}.shell}
          set -g prefix C-a
          unbind C-b
          bind C-a send-prefix
        '';
      };
    };
  };
}
