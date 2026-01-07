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
      userHome = {
        programs = {
          tmux = {
            enable = true;
            keyMode = "vi";
            escapeTime = 0;
            shell = config.modules.home.user.shell.path;

            extraConfig = ''
              set-option -g prefix C-a
              unbind C-b
              bind C-a send-prefix
            '';
          };
        };
      };
    };
}
