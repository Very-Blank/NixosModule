{
  pkgs,
  lib,
  config,
  ...
}:
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
          set-option -g default-shell ${pkgs.zsh}/bin/zsh
          set-option -g default-command ${pkgs.zsh}/bin/zsh
          set-option -g prefix C-a
          unbind C-b
          bind C-a send-prefix
        '';
      };
    };
  };
}
