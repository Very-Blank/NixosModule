{inputs, lib, config, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./user
    (lib.modules.mkAliasOptionModule [ "userHome" ] [ "home-manager" "users" config.modules.home.user.userName ])
  ];

  config = {
    home-manager = {
      useGlobalPkgs = true;
    };

    userHome = {
      xdg = {
        enable = true;
        userDirs.createDirectories = true;
      };

      home = {
        username = config.modules.home.user.userName;
        homeDirectory = "/home/${config.modules.home.user.userName}";

        stateVersion = "24.11";
      };
    };
  };
}
