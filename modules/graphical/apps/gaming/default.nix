{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    modules = {
      graphical = {
        gaming = {
          steam.enable = lib.mkEnableOption "steam";
          minecraft.enable = lib.mkEnableOption "minecraft";
        };
      };
    };
  };

  config = {
    modules.unfreePackages = [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];

    programs = lib.mkIf config.modules.graphical.gaming.steam.enable {
      steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
    };

    userHome = lib.mkIf config.modules.graphical.gaming.minecraft.enable {
      home.packages = [
        pkgs.prismlauncher
      ];
    };
  };
}
