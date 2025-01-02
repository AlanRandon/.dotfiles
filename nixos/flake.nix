{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

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
        flake-compat.follows = "";
      };
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ghostty, not-bad-launcher, ... }@inputs:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        ghostty = ghostty.packages.x86_64-linux.default;
        not-bad-launcher = not-bad-launcher.packages.x86_64-linux.default;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
          ./laptop
        ];
      };
    };
}
