{pkgs, config, lib, ...} : {
  options = {
    modules = {
      tty = {
        greetd = {
          enable = lib.mkEnableOption "TTY1 login with greetd.";

          cmd = lib.mkOption {
            default = "${pkgs.bash}/bin/sh";
            description = "Command to run after login in.";
            type = lib.types.nonEmptyStr;
          };
        };
      };
    };
  };

  config = lib.mkIf config.modules.tty.greetd.enable {
    services = {
      getty = {
        greetingLine = "<< NixOS ${config.system.nixos.release}, ${config.modules.networking.hostname} at your service >>";
        helpLine = lib.mkForce "\n";
      };

      greetd = {
        enable = true;
        settings = {
          terminal = {
            vt = 1;
          };

          default_session = {
            command = "${pkgs.greetd}/bin/agreety --cmd '${config.modules.tty.greetd.cmd}'";
            user = "greeter";
          };
        };
      };
    };
  };
}
