{ pkgs, config, lib, inputs, ... }:

{
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      openssl.dev
    ];
  };

  services.envfs.enable = true;
}
