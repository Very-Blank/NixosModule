{lib, config, pkgs, ... }: {
  options = {
    modules = {
      home = {
        user = {
          name = lib.mkOption {
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
      users.root.password = ""; #for VM
      mutableUsers = true; # true for now
      users.${config.modules.home.user.name} = {
        isNormalUser = true;
        password = "test"; #for VM
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
