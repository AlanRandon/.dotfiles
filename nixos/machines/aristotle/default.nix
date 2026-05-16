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
      limine = {
        enable = true;
        style = {
          backdrop = "303446";
          graphicalTerminal = {
            palette = "303446;e78284;a6d189;e5c890;8caaee;f4b8e4;81c8be;c6d0f5";
            brightPalette = "626880;e78284;a6d189;e5c890;8caaee;f4b8e4;81c8be;c6d0f5";
            background = "303446";
            foreground = "c6d0f5";
            brightBackground = "626880";
            brightForeground = "c6d0f5";
          };
          wallpapers = [ ];
        };
      };
      efi.canTouchEfiVariables = true;
    };
  };

  dotfiles = {
    amd.enable = true;
  };

  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  system.stateVersion = "25.11";
}
