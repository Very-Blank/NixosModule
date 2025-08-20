{lib, config, pkgs, ...}: {
  options = {
    modules = {
      graphical = {
        environment = {
          enable = lib.mkEnableOption "Enables a fully working graphical environment.";
        };
      };
    };
  };

  config = lib.mkIf config.modules.graphical.environment.enable {
    environment = {
      systemPackages = [
        pkgs.uwsm
      ];
    };

    modules = {
      tty.greetd = {
        enable = lib.mkForce true;
        cmd = lib.mkForce "${pkgs.uwsm}/bin/uwsm start -F -- ${pkgs.niri}/bin/niri --session >/dev/null 2>&1";
      };

      graphical = {
        niri = {
          enable = lib.mkForce true;
          terminalEmulator = {
            enable = lib.mkForce true;
            path = lib.mkForce "${pkgs.ghostty}/bin/ghostty";
          };
          dmenu = {
            enable = lib.mkForce true;
            path = lib.mkForce "${pkgs.fuzzel}/bin/fuzzel";
          };
        };

        mako.enable = lib.mkForce true;
        swaybg.enable = lib.mkForce true;
        fuzzel.enable = lib.mkForce true;
        firefox.enable = lib.mkForce true;
        stylix.enable = lib.mkForce true;
      };

      terminal.ghostty.enable = lib.mkForce true;
    };
  };
}
