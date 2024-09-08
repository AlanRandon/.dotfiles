{
  imports = [
    ./file-system.nix
    ./hardware-configuration.nix
    ../nixosModules/sway.nix
    ../nixosModules/firefox.nix
    ../nixosModules/configuration.nix
  ];
}
