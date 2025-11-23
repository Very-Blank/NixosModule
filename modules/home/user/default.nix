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
            description = "Username";
            type = lib.types.nonEmptyStr;
          };

          shell = {
            path = lib.mkOption {
              default = "${pkgs.bash}/bin/bash";
              description = "Path to the shell";
              type = lib.types.nonEmptyStr;
            };

            package = lib.mkPackageOption pkgs "The actual shell package" {
              default = pkgs.bash;
            };
          };

          extraGroups = lib.mkOption {
            type = with lib.types; listOf nonEmptyStr;
            default = [ ];
            description = "Extra groups for the main user";
          };
        };
      };
    };
  };

  config = {
    users = {
      mutableUsers = true; # true for now
      users.${config.modules.home.user.name} = {
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
