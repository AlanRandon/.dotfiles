{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../nixosModules
  ];

  networking.hostName = "plato";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems."/Windows" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ];
  };

  system.stateVersion = "23.11";
}
