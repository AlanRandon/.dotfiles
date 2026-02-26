{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
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
      url = "github:zigtools/zls/0.15.1";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        zig-overlay.follows = "zig-overlay";
      };
    };

    mountui = {
      url = "github:AlanRandon/mountui";
      inputs = {
        # nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      overlays =
        { system }:
        [
          (final: prev: {
            unstable = import inputs.nixpkgs-unstable {
              inherit system;
            };
            custom =
              let
                zig = inputs.zig-overlay.packages.${system}."0.15.1";
              in
              {
                zig = zig;
                mountui = inputs.mountui.packages.${system}.default;
                zls = inputs.zls-overlay.packages.${system}.zls.overrideAttrs (old: {
                  nativeBuildInputs = [ zig ];
                });
              };
          })
        ];

      mkNixosSystem =
        { system, modules }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.overlays = overlays { inherit system; };
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
          modules = [ ./machines/plato ];
        };
        socrates = mkNixosSystem {
          system = "x86_64-linux";
          modules = [ ./machines/socrates ];
        };
      };

      formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".nixfmt-rfc-style;
    };
}
