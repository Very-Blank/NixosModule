{
  config,
  pkgs,
  mkIfModule,
  ...
}:
mkIfModule config [ "graphical" "applications" "other" "obsidian" ] {
  config = {
    modules.unfreePackages = [
      "obsidian"
    ];

    userHome = {
      home.packages = [ pkgs.obsidian ];
    };
  };
}
