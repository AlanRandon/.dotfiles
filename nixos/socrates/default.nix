{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../nixosModules
  ];

  networking.hostName = "socrates";

  dotfiles = {
    intel.enable = true;
    powerManagement.enable = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" ];
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  system.stateVersion = "24.11";
}
