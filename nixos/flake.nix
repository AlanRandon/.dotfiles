{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    zig-overlay = {
      url = "github:mitchellh/zig-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    zls-overlay = {
      url = "github:zigtools/zls";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        zig-overlay.follows = "zig-overlay";
      };
    };

    mountui = {
      url = "github:AlanRandon/mountui";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      mountui,
      zig-overlay,
      zls-overlay,
      ...
    }@inputs:
    let
      mkNixosSystem =
        { system, modules }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    inherit system;
                  };
                  custom =
                    let
                      zig = zig-overlay.packages.${system}."0.15.1";
                    in
                    {
                      zig = zig;
                      mountui = mountui.packages.${system}.default;
                      zls = zls-overlay.packages.${system}.zls.overrideAttrs (old: {
                        nativeBuildInputs = [ zig ];
                      });
                    };
                })
              ];
            }
          ]
          ++ modules;
        };
    in
    {
      # Using Greek Philosophers as hostnames now
      nixosConfigurations = {
        plato = mkNixosSystem {
          system = "x86_64-linux";
          modules = [ ./plato ];
        };
        socrates = mkNixosSystem {
          system = "x86_64-linux";
          modules = [ ./socrates ];
        };
      };

      formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".nixfmt-rfc-style;
    };
}
