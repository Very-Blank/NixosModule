{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    modules = {
      tty = {
        greetd = {
          cmd = lib.mkOption {
            default = "${pkgs.bash}/bin/sh";
            description = "Command to run after login in.";
            type = lib.types.nonEmptyStr;
          };

          autoLogin = lib.mkEnableOption "Auto login, if enabled automatically logins to the main user.";
        };
      };
    };
  };

  config = let
    cfg = config.modules.tty.greetd;
  in
    lib.mkIf cfg.enable {
      services = {
        getty = {
          greetingLine = "<< NixOS ${config.system.nixos.release} >>\n";
          helpLine = lib.mkForce (
            (lib.strings.toUpper (builtins.substring 0 1 config.hostname))
            + (builtins.substring 1 (builtins.stringLength config.hostname) config.hostname)
            + " at your service."
          );
        };

        greetd = {
          enable = true;
          useTextGreeter = true;

          settings = {
            terminal = {
              vt = 1;
            };

            default_session = {
              command = "${pkgs.greetd}/bin/agreety --max-failures 3 --cmd '${cfg.cmd}'";
              user = "greeter";
            };

            initial_session = lib.mkIf cfg.autoLogin {
              command = cfg.cmd;
              user = config.modules.home.user.name;
            };
          };
        };
      };
    };
}
