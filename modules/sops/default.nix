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
  };
}
