{ pkgs, config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixosModules
  ];

  networking.hostName = "aristotle";

  hardware = {
    tuxedo-drivers.enable = true;
    tuxedo-rs = {
      enable = true;
      tailor-gui.enable = true;
    };
  };

  services.power-profiles-daemon.enable = true;

  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ yt6801 ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      limine.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  dotfiles = {
    amd.enable = true;
  };

  system.stateVersion = "25.11";
}
