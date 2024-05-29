# sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
# sudo nix-channel --update

{ config, lib, pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> {
    config = { allowUnfree = true; };
  };

  catppuccin-gtk = (pkgs.catppuccin-gtk.override { accents = [ "blue" "green" ]; });

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
  imports =
    [
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

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

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "%wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
    useDefaultShell = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "23.11";

  environment.systemPackages = with pkgs; [
    git
    github-cli
    tmux
    unstable.fzf
    ripgrep
    bc
    htop
    wget
    zsh
    jq
    clang
    strace
    gnumake
    unzip
    nodejs
    xdg-utils
    rustup
    pkg-config
    nasm

    # Window manager
    xwayland
    sway
    waybar
    brightnessctl
    sway-launcher-desktop
    wl-clipboard
    grim
    slurp
    catppuccin-gtk
    gtk3
    glib

    # Browser
    firefox

    # Terminal
    unstable.alacritty

    # Text editor
    neovim

    # Image editor
    gimp

    # Notifications
    mako
    libnotify

    # Sound
    playerctl
    pulseaudio
    mpv
    pavucontrol

    # Screen recording
    dbus-sway-environment
    pipewire
    wireplumber

    # LaTeX
    unstable.tectonic
    zathura
    poppler_utils
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraMono" ]; })
    pkgs.noto-fonts-color-emoji
  ];

  hardware.opengl.enable = true;
  programs.sway.enable = true;
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  services.gnome.gnome-keyring.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    zlib
    openssl.dev
  ];

  users.defaultUserShell = pkgs.zsh;

  environment.etc."xdg/gtk-2.0/gtkrc".text = ''
    gtk-theme-name = "Catppuccin-Frappe-Standard-Green-Dark"
    gtk-application-prefer-dark-theme = true
  '';

  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name = Catppuccin-Frappe-Standard-Green-Dark
    gtk-application-prefer-dark-theme = true
  '';

  environment.etc."xdg/gtk-4.0/assets".source = "${catppuccin-gtk}/share/themes/Catppuccin-Frappe-Standard-Green-Dark/gtk-4.0/assets";
  environment.etc."xdg/gtk-4.0/gtk.css".source = "${catppuccin-gtk}/share/themes/Catppuccin-Frappe-Standard-Green-Dark/gtk-4.0/gtk.css";
  environment.etc."xdg/gtk-4.0/gtk-dark.css".source = "${catppuccin-gtk}/share/themes/Catppuccin-Frappe-Standard-Green-Dark/gtk-4.0/gtk-dark.css";

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

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
}
