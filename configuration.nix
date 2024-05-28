# sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
# sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# sudo nix-channel --add https://github.com/catppuccin/nix/archive/main.tar.gz catppuccin
# sudo nix-channel --update

# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
  unstable = import <nixpkgs-unstable> {
    config = { allowUnfree = true; };
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
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

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alan = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "%wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [];
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
	neovim
	firefox
	tmux
	wget
	git
	pulseaudio
	zsh
	sway
	unstable.alacritty
	brightnessctl
	waybar
	pavucontrol
	wl-clipboard
	jq
	unstable.fzf
	clang
	mako
	libnotify
	playerctl
	gnumake
	ripgrep
	unzip
	nodejs
	gtk3
	catppuccin-gtk
	github-cli
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraMono" ]; })
  ];

  hardware.opengl.enable = true;
  programs.sway.enable = true;
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [];

  users.defaultUserShell = pkgs.zsh;
  services.gnome.gnome-keyring.enable = true;

  environment.etc."xdg/gtk-2.0/gtkrc".text = ''
    gtk-theme-name = "Catppuccin-Frappe-Standard-Green-Dark"
  '';

  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name = Catppuccin-Frappe-Standard-Green-Dark
  '';
}

