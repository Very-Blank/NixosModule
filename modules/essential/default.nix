{
  pkgs,
  config,
  mkModule,
  ...
}:
mkModule config [ "essential" ] {
  config = {
    programs = {
      nano.enable = false;
      vim.enable = true;
    };

    environment.systemPackages = [
      pkgs.wget
      pkgs.unzip
    ];

    time.timeZone = "Europe/Helsinki";
  };
}
