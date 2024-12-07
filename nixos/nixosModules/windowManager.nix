{ pkgs, ... }:

{
  environment.systemPackages =
    with pkgs; [
      # (writeTextFile
      #   {
      #     name = "dbus-sway-environment";
      #     destination = "/bin/dbus-sway-environment";
      #     executable = true;

      #     text = ''
      #       dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      #       systemctl --user stop pipewire wireplumber pipewire-pulse xdg-desktop-portal xdg-desktop-portal-wlr
      #       systemctl --user start pipewire wireplumber pipewire-pulse xdg-desktop-portal xdg-desktop-portal-wlr
      #     '';
      #   })

      # Notifications
      mako
      libnotify

      # X11
      xwayland

      # Screenshots
      grim
      slurp

      # Screen recording
      pipewire
      wireplumber

      # Wallpaper
      # swaybg
      hyprpaper

      # Launcher
      fuzzel

      # Statusbar
      waybar

      # Brightness	
      brightnessctl

      # Clipboard
      wl-clipboard

      # Cursor theme
      catppuccin-cursors.frappeLight
    ];

  programs = {
    # sway.enable = true;
    hyprland.enable = true;
    hyprlock.enable = true;
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings = {
            "org/gnome/desktop/interface" = {
              cursor-theme = "catppuccin-frappe-light-cursors";
            };
          };
          lockAll = true;
        }
      ];
    };
  };

  environment.etc = {
    "xdg/gtk-2.0/gtkrc".text = ''
      gtk-application-prefer-dark-theme = true
      gtk-cursor-theme-name="catppuccin-frappe-light-cursors"
    '';

    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme = true
      gtk-cursor-theme-name = catppuccin-frappe-light-cursors
    '';
  };

  services = {
    libinput.enable = true;
    dbus.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --user-menu --time --cmd Hyprland";
          user = "greeter";
        };
      };
    };
    kanata = {
      enable = true;
      keyboards.default.config = ''
        (defsrc
        	caps)
  
        (deflayermap (default-layer)
            caps (tap-hold 200 200 esc lmet))
      '';
    };
    pipewire = {
      alsa.enable = true;
      pulse.enable = true;
    };
  };
}
