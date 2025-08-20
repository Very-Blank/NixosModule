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
        greetingLine = " << NixOS ${config.system.nixos.release} >>\n";
        helpLine = lib.mkForce " ${(lib.strings.toUpper (builtins.substring 0 1 config.modules.networking.hostname))}${(builtins.substring 1 (builtins.stringLength config.modules.networking.hostname) config.modules.networking.hostname)} at your service.";
      };

      greetd = {
        enable = true;
        settings = {
          terminal = {
            vt = 1;
          };

          default_session = {
            command = "${pkgs.greetd}/bin/agreety --max-failures 3 --cmd '${config.modules.tty.greetd.cmd}'";
            user = "greeter";
          };
        };
      };
    };
  };
}
