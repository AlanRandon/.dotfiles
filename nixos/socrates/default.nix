{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../nixosModules
  ];

  networking.hostName = "socrates";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  system.stateVersion = "24.11";
}
