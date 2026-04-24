{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.dotfiles.display-manager;
in
{
  options.dotfiles.display-manager.enable = lib.mkEnableOption "Enable display manager" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (catppuccin-sddm.override {
        flavor = "frappe";
        accent = "green";
        font = "FiraMono Nerd Font";
        fontSize = "11";
        background = "/var/lib/sddm-wallpapers/current";
        loginBackground = true;
        clockEnabled = false;
      })
    ];

    systemd.services.display-manager.preStart = ''
      mkdir -p /var/lib/sddm-wallpapers
      rm -rf /var/lib/sddm-wallpapers/*
      WALLPAPER=$(find /home/alan/Pictures/wallpapers -type f \
        \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) \
        | shuf -n 1)
      cp "$WALLPAPER" /var/lib/sddm-wallpapers/current
    '';

    services.displayManager.sddm = {
      enable = true;
      theme = "catppuccin-frappe-green";
      package = pkgs.kdePackages.sddm;
      wayland.enable = true;
      settings = {
        General = {
          GreeterEnvironment = "QT_SCALE_FACTOR=2.25";
        };
      };
    };
  };
}
