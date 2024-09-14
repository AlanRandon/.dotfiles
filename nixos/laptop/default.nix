{
  imports = [
    ./file-system.nix
    ./hardware-configuration.nix
    ../nixosModules/windowManager.nix
    ../nixosModules/firefox.nix
    ../nixosModules/configuration.nix
  ];
}
