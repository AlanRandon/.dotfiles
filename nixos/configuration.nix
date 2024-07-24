{ lib, pkgs, ... }:

let
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire wireplumber pipewire-pulse xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire wireplumber pipewire-pulse xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };
in
{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce "uk";
    useXkbConfig = true; # use xkb.options in tty.
  };

  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "%wheel" "dialout" "uinput" ]; # Enable ‘sudo’ for the user.
    packages = [ ];
    useDefaultShell = true;
  };

  system.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [
    pkgs.unzip
    pkgs.xdg-utils
    pkgs.bashmount

    # Git
    pkgs.git
    pkgs.github-cli

    # Languages
    pkgs.rustup
    pkgs.opam
    pkgs.nodejs
    pkgs.clang
    pkgs.nasm

    # Development tools
    pkgs.pkg-config
    pkgs.strace
    pkgs.gnumake
    pkgs.autoconf

    # Command line utilities
    pkgs.unstable.fzf
    pkgs.tree
    pkgs.ffmpeg
    pkgs.figlet
    pkgs.lolcat
    pkgs.bat
    pkgs.bc
    pkgs.wget
    pkgs.ripgrep
    pkgs.jq
    pkgs.btop

    # Window manager
    pkgs.xwayland
    pkgs.sway
    pkgs.swaybg
    pkgs.swaylock-effects
    pkgs.catppuccin-cursors.frappeLight
    pkgs.waybar
    pkgs.brightnessctl
    pkgs.sway-launcher-desktop
    pkgs.wl-clipboard
    pkgs.grim
    pkgs.slurp

    # Browser
    pkgs.firefox

    # Shell
    pkgs.zsh

    # Terminal
    pkgs.unstable.alacritty # Emulator
    pkgs.tmux # Multiplexer

    # Text editor
    pkgs.unstable.neovim
    pkgs.vscode # for liveshare

    # Image editor
    pkgs.gimp

    # Sound editor
    pkgs.audacity

    # Notifications
    pkgs.mako
    pkgs.libnotify

    # Sound
    pkgs.playerctl
    pkgs.pulseaudio
    pkgs.mpv
    pkgs.pavucontrol

    # Screen recording
    dbus-sway-environment
    pkgs.pipewire
    pkgs.wireplumber

    # LaTeX
    pkgs.unstable.tectonic
    pkgs.zathura
    pkgs.poppler_utils
  ];

  fonts.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraMono" ]; })
    pkgs.noto-fonts-color-emoji
  ];

  hardware.opengl.enable = true;
  programs.zsh.enable = true;

  services.gnome.gnome-keyring.enable = true;

  services.envfs.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    pkgs.zlib
    pkgs.openssl.dev
  ];

  users.defaultUserShell = pkgs.zsh;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --user-menu --time --cmd sway";
        user = "greeter";
      };
    };
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  services.udisks2.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  services.pipewire = {
    alsa.enable = true;
    pulse.enable = true;
  };

  xdg.mime.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
    "image/png" = "gimp.desktop";
  };

  programs.sway.enable = true;

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

  programs.dconf = {
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

  services.kanata = {
    enable = true;
    keyboards.default.config = ''
      (defsrc
      	caps)
  
      (deflayermap (default-layer)
          caps (tap-hold 200 200 esc lmet))
    '';
  };
}
