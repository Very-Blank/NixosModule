{
  lib,
  config,
  ...
}: {
  options = {
    modules = {
      terminal = {
        tmux = {
          enable = lib.mkEnableOption "Enables the terminal tmux module";
        };
      };
    };
  };

  config = let
    cfg = config.modules.terminal.tmux;
  in
    lib.mkIf cfg.enable {
      programs = {
        tmux = {
          enable = true;
          escapeTime = 0;
          keyMode = "vi";
          extraConfig = ''
            set-option -g prefix C-a
            unbind C-b
            bind C-a send-prefix
          '';
        };
      };

      userHome = {
        programs = {
          tmux = {
            enable = true;
            keyMode = "vi";
            shell = config.modules.home.user.shell.path;
          };
        };
      };
    };
}
