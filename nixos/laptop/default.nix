{ pkgs, ... }:

{
  imports = [
    ./file-system.nix
    ./hardware-configuration.nix
    ../nixosModules
  ];

  networking.hostName = "nixos";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  system.stateVersion = "23.11";
}
