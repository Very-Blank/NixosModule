{inputs, lib, config, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./user
    (lib.modules.mkAliasOptionModule [ "userHome" ] [ "home-manager" "users" config.modules.home.user.name ])
  ];

  config = {
    home-manager = {
      useGlobalPkgs = true;
    };

    userHome = {
      accounts.calendar = {}; 

      xdg = {
        enable = true;
        userDirs.createDirectories = true;
      };

      home = {
        username = config.modules.home.user.name;
        homeDirectory = "/home/${config.modules.home.user.name}";

        stateVersion = "24.11";
      };
    };
  };
}
