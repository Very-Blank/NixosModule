{inputs, lib, config}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./user.nix
    (lib.modules.mkAliasOptionModule [ "mainUserHome" ] [ "home-manager" "users" config.mainUser.userName ])
  ];

  config = {
    home-manager = {
      enable = true;
      useGlobalPkgs = true;
    };

    mainUserHome = {
      xdg = {
        enable = true;
        userDirs.createDirectories = true;
      };

      home = {
        username = config.mainUser.userName;
        homeDirectory = "/home/${config.mainUser.userName}";
        stateVersion = "24.11";
      };
    };
  };
}
