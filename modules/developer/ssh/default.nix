{
  lib,
  config,
  mkModule,
  ...
}:
mkModule config [ "developer" "ssh" ] {
  options = {
    keys = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            match = lib.mkOption {
              type = lib.types.str;
              description = "Match pattern.";
            };

            hostname = lib.mkOption {
              type = lib.types.str;
              description = "Hostname.";
            };

            user = lib.mkOption {
              type = lib.types.str;
              description = "Username.";
            };
          };
        }
      );
    };
  };

  config = cfg: {
    userHome = {
      sops.secrets =
        lib.attrsets.genAttrs' cfg.keys (
          option:
          lib.attrsets.nameValuePair ("ssh-keys/pub/" + option.hostname) ({
            sopsFile = ../../../secrets/user/. + "/${config.hostname}.yaml";
            path = ".ssh/${option.hostname}.pub";
            mode = "0644";
          })
        )
        // lib.attrsets.genAttrs' cfg.keys (
          option:
          lib.attrsets.nameValuePair ("ssh-keys/private/" + option.hostname) ({
            sopsFile = ../../../secrets/user/. + "/${config.hostname}.yaml";
            path = ".ssh/${option.hostname}";
            mode = "0600";
          })
        );

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        matchBlocks = lib.attrsets.genAttrs' cfg.keys (
          option:
          lib.attrsets.nameValuePair (option.match) ({
            user = option.user;
            hostname = option.hostname;
            identityFile = config.userHome.sops.secrets."ssh-keys/pub/${option.hostname}".path;
          })
        );
      };
    };
  };
}
