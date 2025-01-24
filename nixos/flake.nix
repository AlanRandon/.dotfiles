{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
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
        flake-utils.follows = "flake-utils";
      };
    };

    not-bad-launcher = {
      url = "github:AlanRandon/not-bad-launcher";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs = {
        nixpkgs-stable.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
        zig.follows = "zig-overlay";
      };
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , ghostty
    , not-bad-launcher
    , zig-overlay
    , zls-overlay
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
        };
      };
      overlay-custom = final: prev:
        let zig = zig-overlay.packages.x86_64-linux.master;
        in {
          custom = {
            zig = zig;
            ghostty = ghostty.packages.x86_64-linux.default;
            not-bad-launcher = not-bad-launcher.packages.x86_64-linux.default;
            zls = zls-overlay.packages.x86_64-linux.zls.overrideAttrs (old: {
              nativeBuildInputs = [ zig ];
            });
          };
        };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [
              overlay-unstable
              overlay-custom
            ];
          })
          ./laptop
        ];
      };
    };
}
