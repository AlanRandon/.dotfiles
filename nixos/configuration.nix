{ lib, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    unzip
    xdg-utils
    bashmount

    # Git
    github-cli

    # Languages
    rustup
    opam
    nodejs
    clang
    nasm

    # Development tools
    pkg-config
    strace
    gnumake
    autoconf
    gdb

    # Command line utilities
    unstable.fzf
    tree
    ffmpeg
    figlet
    lolcat
    bat
    bc
    wget
    ripgrep
    fd
    jq
    btop
    glow

    # Terminal
    unstable.alacritty # Emulator
    tmux # Multiplexer

    # Text editor
    unstable.neovim
    vscode # for liveshare

    # Image editor
    gimp

    # Sound editor
    audacity

    # Sound
    playerctl
    pulseaudio
    mpv
    pavucontrol

    # LaTeX
    unstable.tectonic
    zathura
    poppler_utils
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraMono" ]; })
    noto-fonts-color-emoji
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.alan = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "%wheel" "dialout" "uinput" ]; # Enable ‘sudo’ for the user.
      packages = [ ];
      useDefaultShell = true;
    };
    defaultUserShell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
    git.enable = true;
    firefox = {
      enable = true;
      languagePacks = [ "en-GB" "en-US" ];
      policies =
        {
          DisablePocket = true;
          ExtensionSettings = {
            # uBlock Origin
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            # Vimium
            "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
              installation_mode = "force_installed";
            };
            # Firefox Color
            "FirefoxColor@mozilla.com" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox-color/latest.xpi";
              installation_mode = "force_installed";
            };
            # Stylus
            "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/styl-us/latest.xpi";
              installation_mode = "force_installed";
            };
          };
          Preferences =
            let
              value = val: { Value = val; Status = "locked"; };
            in
            {
              "browser.startup.homepage" = value "https://github.com";
              "browser.newtabpage.enabled" = value false;
              "toolkit.legacyUserProfileCustomizations.stylesheets" = value true;
            };
        };
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        openssl.dev
      ];
    };
  };

  services = {
    gnome.gnome-keyring.enable = true;
    envfs.enable = true;
    udisks2.enable = true;
  };

  hardware = {
    pulseaudio.enable = true;
    opengl.enable = true;
  };

  sound.enable = true;

  xdg.mime.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
    "image/png" = "mpv.desktop";
    "video/vnd.avi" = "mpv.desktop";
  };

  system.stateVersion = "23.11";
}
