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

      secrets."user/password-hash" = {
        sopsFile = ../../secrets/user/shared.yaml;
        neededForUsers = true;
      };
    };
  };
}
