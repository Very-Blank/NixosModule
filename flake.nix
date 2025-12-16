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
    zls.url = "github:Very-Blank/zls";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim = {
      url = "github:Very-Blank/nvim";
      flake = false;
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
          options = lib.setAttrByPath ([ "modules" ] ++ path) moduleContent.options;
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
        zeus = mkNixosConfig {
          name = "zeus";
          system = "x86_64-linux";
        };

        aether = mkNixosConfig {
          name = "aether";
          system = "x86_64-linux";
        };

        hermes = mkNixosConfig {
          name = "hermes";
          system = "x86_64-linux";
        };
      };
    };
}
