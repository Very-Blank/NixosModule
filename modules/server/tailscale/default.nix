{
  pkgs,
  lib,
  config,
  mkIfModule,
  ...
}:
mkIfModule config
  [
    "server"
    "tailscale"
  ]
  {
    options = {
      domain = lib.mkOption {
        default = "example.com";
        description = "Hostname";
        type = lib.types.nonEmptyStr;
      };

      telemetry.enabled = lib.mkEnableOption "Is tailscale's logging and telemetry enabled, lessens privacy.";
    };

    config = cfg: {
      environment.systemPackages = [ pkgs.tailscale ];

      services = {
        tailscale = {
          enable = true;
          extraDaemonFlags = lib.mkIf (!cfg.telemetry.enabled) [ "--no-logs-no-support" ];
        };
      };

      networking.firewall = {
        trustedInterfaces = [ "tailscale0" ];
        allowedUDPPorts = [ config.services.tailscale.port ];
      };
    };
  }
