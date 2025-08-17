{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim = {
      url = "github:Very-Blank/nvim";
      flake = false;
    };
  };

  outputs = inputs: 
    let
      inherit (inputs) nixpkgs;
      x86_64System = "x86_64-linux";
    in 
    {
      nixosConfigurations = {
        zeus = nixpkgs.lib.nixosSystem {
          inherit x86_64System;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/zeus
          ];
        };
      };
    };
}
