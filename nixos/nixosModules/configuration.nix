{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unzip
    xdg-utils
    bashmount
    unstable.newsboat
    powertop
    networkmanagerapplet

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
  };

  services = {
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
    pulseaudio.enable = true;
    opengl.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  sound.enable = true;

  xdg.mime.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
    "image/png" = "mpv.desktop";
    "video/vnd.avi" = "mpv.desktop";
  };

  security.pki.certificates = [
    (builtins.readFile ../../certificates/securly.pem)
    (builtins.readFile ../../certificates/school.pem)
  ];
}
