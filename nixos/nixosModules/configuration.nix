{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bluetuith
    hyperfine
    unzip
    xdg-utils
    bashmount
    unstable.newsboat
    powertop
    networkmanagerapplet
    wasmtime
    sshfs
    wakeonlan

    # Git
    github-cli

    # Languages
    rustup
    unstable.cargo-shuttle
    nodejs
    clang
    nasm
    python312

    # Development tools
    pkg-config
    strace
    gnumake
    autoconf
    gdb
    binaryen
    httplz

    # Command line utilities
    unstable.fzf
    tree
    ffmpeg
    figlet
    lolcat
    bat
    bc
    wget
    dig
    ripgrep
    fd
    jq
    btop
    glow
    unixtools.xxd
    unstable.yazi
    timg

    # Terminal
    unstable.alacritty # Emulator
    ghostty
    tmux # Multiplexer

    # Text editor
    unstable.neovim
    # vscode # for liveshare

    # Image editor
    gimp

    # Sound editor
    audacity

    # Sound
    playerctl
    mpv
    pavucontrol
    pulseaudio

    # LaTeX
    unstable.tectonic
    zathura
    poppler_utils

    google-chrome
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraMono" ]; })
    noto-fonts-color-emoji
  ];

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
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
  };

  services = {
    printing.enable = true;
    gnome.gnome-keyring.enable = true;
    udisks2.enable = true;
    blueman.enable = true;
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };
  };

  powerManagement.powertop.enable = true;

  hardware = {
    # pulseaudio.enable = true;
    graphics.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  xdg.mime.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
    "image/png" = "mpv.desktop";
    "image/jpeg" = "mpv.desktop";
    "image/webp" = "mpv.desktop";
    "image/avif" = "mpv.desktop";
    "video/vnd.avi" = "mpv.desktop";
    "video/mp4" = "mpv.desktop";
    "inode/directory" = "nvim.desktop";
  };

  security.pki.certificates = [
    (builtins.readFile ../../certificates/securly.pem)
    (builtins.readFile ../../certificates/school.pem)
  ];
}
