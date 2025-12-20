{
  pkgs,
  inputs,
  config,
  mkModule,
  ...
}:
{

  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
}
// mkModule config [ "sops" ] {
  options = {
  };
  config = {
    environment.systemPackages = [
      pkgs.sops
      pkgs.age
    ];

    sops = {
      age.keyFile = "/home/${config.modules.home.user.name}/.config/sops/age/keys.txt";
    };

    userHome = {
      imports = [
        inputs.sops-nix.homeManagerModules.sops
      ];

      sops = {
        gnupg = {
          home = "~/.gnupg";
          sshKeyPaths = [ ];
        };

        defaultSymlinkPath = "/run/user/1000/secrets";
        defaultSecretsMountPoint = "/run/user/1000/secrets.d";
      };
    };
  };
}
