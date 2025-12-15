{
  config,
  mkIfModule,
  ...
}:
mkIfModule config [ "graphical" "applications" "other" "steam" ] {
  config = {
    modules.unfreePackages = [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];

    programs.steam = {
      enable = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
