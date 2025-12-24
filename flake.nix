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

    base16.url = "github:SenchoPens/base16.nix";

    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
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

    zig.url = "github:mitchellh/zig-overlay";
    zls.url = "github:Very-Blank/zls";

    nvim = {
      url = "github:Very-Blank/nvim";
      flake = false;
    };

    nixnvim = {
      url = "github:very-blank/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      inherit (inputs) nixpkgs;

      # We pass the config so we can lazyly do cfg.options
      mkIfModule =
        lib: config: path: moduleContent:
        let
          cfg = lib.getAttrFromPath ([ "modules" ] ++ path) config;

          optionsWithEnable = {
            enable = lib.mkEnableOption "Enable the ${lib.last path} module.";
          }
          // (moduleContent.options or { });

          rawConfig =
            if builtins.hasAttr "config" moduleContent && builtins.isFunction moduleContent.config then
              moduleContent.config cfg
            else
              (moduleContent.config or { });
        in
        {
          options = lib.setAttrByPath ([ "modules" ] ++ path) optionsWithEnable;
          config = lib.mkIf cfg.enable rawConfig;
        };

      mkModule =
        lib: config: path: moduleContent:
        let
          cfg = lib.getAttrFromPath ([ "modules" ] ++ path) config;

          rawConfig =
            if builtins.hasAttr "config" moduleContent && builtins.isFunction moduleContent.config then
              moduleContent.config cfg
            else
              (moduleContent.config or { });
        in
        {
          options = lib.setAttrByPath ([ "modules" ] ++ path) (moduleContent.options or { });
          config = rawConfig;
        };

      mkNixosConfig =
        {
          name,
          system,
        }:
        nixpkgs.lib.nixosSystem {
          system = system;

          specialArgs = {
            inherit inputs;

            mkModule = mkModule nixpkgs.lib;
            mkIfModule = mkIfModule nixpkgs.lib;
          };

          modules = [
            ./hosts/${name}
          ];
        };

    in
    {
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
