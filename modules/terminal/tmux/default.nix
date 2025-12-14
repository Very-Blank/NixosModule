{
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "terminal" "tmux" ] {
  config = {
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
