{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    colors = {
      url = "github:Very-Blank/colors";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    nixnvim = {
      url = "github:Very-Blank/NixNvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    inherit (inputs) nixpkgs;

    mkNixosConfig = {
      name,
      system,
    }:
      nixpkgs.lib.nixosSystem {
        system = system;

        specialArgs = {
          inherit inputs;
        };

        modules = [
          ./hosts/${name}
        ];
      };
  in {
    nixosConfigurations = {
      zaratul = mkNixosConfig {
        name = "zaratul";
        system = "x86_64-linux";
      };

      ouroboros = mkNixosConfig {
        name = "ouroboros";
        system = "x86_64-linux";
      };

      hermes = mkNixosConfig {
        name = "hermes";
        system = "x86_64-linux";
      };
    };
  };
}
