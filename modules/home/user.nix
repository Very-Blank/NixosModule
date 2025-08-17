{lib, config, pkgs}: {
  options = {
    mainUser = {
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

  config = {
    users = {
      mutableUsers = false;
      users.${config.mainUser.userName} = {
        isNormalUser = true;
        extraGroups = config.mainUser.extraGroups ++ [
          "wheel"
          "video"
          "input"
          "audio"
        ];
      };
    };
  };
}
