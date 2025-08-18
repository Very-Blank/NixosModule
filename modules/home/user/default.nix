{lib, config, pkgs, ... }: {
  options = {
    modules = {
      home = {
        user = {
          userName = lib.mkOption {
            default = "blank";
            description = "Username";
            type = lib.types.nonEmptyStr;
          };

          extraGroups = lib.mkOption {
            type = with lib.types; listOf nonEmptyStr;
            default = [];
            description = "Extra groups for the main user";
          };
        };
      };
    };
  };

  config = {
    users = {
      mutableUsers = true; # true for now
      users.${config.modules.home.user.userName} = {
        isNormalUser = true;
        shell = lib.mkOverride 1 pkgs.bash; # This is overwritten by zsh if enabled
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
