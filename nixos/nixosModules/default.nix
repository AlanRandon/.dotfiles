{ lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "google-chrome"
    ];

  imports = [
    ./nixosSupport.nix
    ./packages.nix
    ./windowManager.nix
    ./firefox.nix
    ./ssh.nix
    ./tor.nix
    ./man.nix
    ./samba.nix
    ./git.nix
  ];

  boot.tmp.cleanOnBoot = true;

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
      extraGroups = [
        "wheel"
        "networkmanager"
        "%wheel"
        "dialout"
        "uinput"
      ]; # Enable ‘sudo’ for the user.
      packages = [ ];
      useDefaultShell = true;
      uid = 1000;
    };
    defaultUserShell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
  };

  services = {
    printing.enable = true;
    gnome.gnome-keyring.enable = true;
    udisks2.enable = true;
    blueman.enable = true;
  };

  powerManagement.powertop.enable = true;

  hardware = {
    # pulseaudio.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # these may do something?
        # intel-media-driver
        # intel-vaapi-driver
        # vaapiVdpau
        # intel-compute-runtime
        # intel-ocl
        intel-compute-runtime-legacy1
      ];
    };
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
