{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    modules = {
      home = {
        user = {
          name = lib.mkOption {
            default = "blank";
            description = "Username.";
            type = lib.types.nonEmptyStr;
          };

          shell = {
            path = lib.mkOption {
              default = "${pkgs.bash}/bin/bash";
              description = "Path to the shell.";
              type = lib.types.nonEmptyStr;
            };

            package = lib.mkPackageOption pkgs "The actual shell package." {
              default = pkgs.bash;
            };
          };

          extraGroups = lib.mkOption {
            type = with lib.types; listOf nonEmptyStr;
            default = [ ];
            description = "Extra groups for the user.";
          };
        };
      };
    };
  };

  config = {
    sops.secrets."user/password-hash" = {
      sopsFile = ../../../secrets/user/shared.yaml;
      neededForUsers = true;
    };

    users = {
      mutableUsers = false;

      users.${config.modules.home.user.name} = {

        hashedPasswordFile = config.sops.secrets."user/password-hash".path;
        isNormalUser = true;

        shell = config.modules.home.user.shell.package;

        extraGroups = config.modules.home.user.extraGroups ++ [
          "wheel"
          "video"
          "input"
          "audio"
        ];
      };
    };
  };
}
