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

    not-bad-launcher = {
      url = "github:AlanRandon/not-bad-launcher";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
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
      not-bad-launcher,
      mountui,
      zig-overlay,
      zls-overlay,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
        };
      };
      overlay-custom =
        final: prev:
        let
          zig = zig-overlay.packages.${system}.master;
        in
        {
          custom = {
            zig = zig;
            mountui = mountui.packages.${system}.default;
            not-bad-launcher = not-bad-launcher.packages.${system}.default;
            zls = zls-overlay.packages.${system}.zls.overrideAttrs (old: {
              nativeBuildInputs = [ zig ];
            });
          };
        };
    in
    {
      # Using Greek Philosophers as hostnames now
      nixosConfigurations = {
        plato = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.overlays = [
                overlay-unstable
                overlay-custom
              ];
            }
            ./plato
          ];
        };
        socrates = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.overlays = [
                overlay-unstable
                overlay-custom
              ];
            }
            ./socrates
          ];
        };
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
}
