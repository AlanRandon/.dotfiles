{ lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "google-chrome"
    ];

  imports = [
    ./base.nix
    ./nixosSupport.nix
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
    ./bluetooth.nix
    ./printing.nix
  ];

  powerManagement.powertop.enable = true;

  security.pki.certificates = [
    (builtins.readFile ../../certificates/securly.pem)
    (builtins.readFile ../../certificates/school.pem)
  ];
}
