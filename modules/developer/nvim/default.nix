{
  inputs,
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "developer" "nvim" ] {
  config = {
    userHome = {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
      };

      xdg.configFile."nvim" = {
        enable = true;
        source = inputs.nvim;
      };
    };
  };
}
