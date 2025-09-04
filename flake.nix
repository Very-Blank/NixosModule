{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    zig.url = "github:mitchellh/zig-overlay";
    zls.url = "github:zigtools/zls/0.15.0";

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
          system = x86_64System;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/zeus
          ];
        };

        hermes = nixpkgs.lib.nixosSystem {
          system = x86_64System;
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./hosts/hermes
          ];
        };
      };
    };
}
