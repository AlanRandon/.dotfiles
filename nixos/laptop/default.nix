{
  imports = [
    ./file-system.nix
    ./hardware-configuration.nix
    ../nixosModules/windowManager.nix
    ../nixosModules/firefox.nix
    ../nixosModules/configuration.nix
    ../nixosModules/nixosSupport.nix
  ];

  networking.hostName = "nixos";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "23.11";
}
