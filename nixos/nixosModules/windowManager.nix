{
  pkgs,
  config,
  lib,
  ...
}:

let
  enabled = config.dotfiles.window-manager.enable;
in
{
  options.dotfiles.window-manager.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable window manager";
  };

  config = lib.mkIf enabled {
    environment.systemPackages = with pkgs; [
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
      hyprpaper

      # Launcher
      fuzzel

      # Statusbar
      waybar

      # Brightness
      brightnessctl

      # Clipboard
      wl-clipboard

      wtype

      # Cursor theme
      catppuccin-cursors.frappeLight
      (unstable.magnetic-catppuccin-gtk.override {
        tweaks = [ "frappe" ];
        accent = [ "green" ];
      })

      adwaita-icon-theme
      hicolor-icon-theme

      # Privileges
      hyprpolkitagent

      networkmanagerapplet
      unstable.ghostty
      pulseaudio
    ];

    programs = {
      hyprland.enable = true;
      hyprlock.enable = true;
      dconf = {
        enable = true;
        profiles.user.databases = [
          {
            settings = {
              "org/gnome/desktop/interface" = {
                cursor-theme = "catppuccin-frappe-light-cursors";
                application-prefer-dark-theme = true;
                color-scheme = "prefer-dark";
                gtk-theme = "Catppuccin-GTK-Green-Dark-Frappe";
                gtk-icon-theme = "Adwaita";
              };
            };
            lockAll = true;
          }
        ];
      };
    };

    xdg.icons.enable = true;
    gtk.iconCache.enable = true;

    fonts.packages = with pkgs; [
      nerd-fonts.fira-mono
      noto-fonts-color-emoji
    ];

    environment.etc = {
      "xdg/gtk-2.0/gtkrc".text = ''
        gtk-application-prefer-dark-theme = true
        gtk-cursor-theme-name="catppuccin-frappe-light-cursors"
        gtk-theme-name = "Catppuccin-GTK-Green-Dark-Frappe"
        gtk-icon-theme-name = "Adwaita"
      '';

      "xdg/gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-application-prefer-dark-theme = true
        gtk-cursor-theme-name = catppuccin-frappe-light-cursors
        gtk-theme-name = Catppuccin-GTK-Green-Dark-Frappe
        gtk-icon-theme-name = Adwaita
      '';
    };

    services = {
      libinput.enable = true;
      dbus.enable = true;
      upower.enable = true;
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --remember --user-menu --time --cmd Hyprland";
            user = "greeter";
          };
        };
      };
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
      };
    };
  };
}
