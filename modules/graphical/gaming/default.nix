{lib, config, pkgs,...}: {
  options = {
    modules = {
      graphical = {
        gaming = {
          enable = lib.mkEnableOption "Gaming";
        };
      };
    };
  };

  config = lib.mkIf config.modules.graphical.gaming.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];

    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
    };
  };
}
