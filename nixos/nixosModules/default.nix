{ lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "google-chrome"
    ];

  imports = [
    ./nixosSupport.nix
    ./base.nix
    ./packages.nix
    ./windowManager.nix
    ./firefox.nix
    ./ssh.nix
    ./tor.nix
    ./man.nix
    ./samba.nix
    ./virtManager.nix
    ./intel.nix
    ./email.nix
    ./mimeapps.nix
  ];

  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  programs.bandwhich.enable = true;

  services = {
    printing.enable = true;
    udisks2.enable = true;
    blueman.enable = true;
  };

  powerManagement.powertop.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  security.pki.certificates = [
    (builtins.readFile ../../certificates/securly.pem)
    (builtins.readFile ../../certificates/school.pem)
  ];
}
