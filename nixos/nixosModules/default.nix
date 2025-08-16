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
    ./tmux.nix
    ./virtManager.nix
    ./intel.nix
    ./email.nix
    ./mimeapps.nix
  ];

  boot.tmp.cleanOnBoot = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-mono
    noto-fonts-color-emoji
  ];

  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

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
      initialHashedPassword = "$y$j9T$Eyu1AFhGHTSfunmXO2G2b0$qWXs1yzrYxD1eBveUI96tqkVrb0JMmzmjFGfT/pSNrD";
      uid = 1000;
    };
    defaultUserShell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
    bandwhich.enable = true;
  };

  services = {
    printing.enable = true;
    gnome.gnome-keyring.enable = true;
    udisks2.enable = true;
    blueman.enable = true;
  };

  powerManagement.powertop.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  security.pki.certificates = [
    (builtins.readFile ../../certificates/securly.pem)
    (builtins.readFile ../../certificates/school.pem)
  ];
}
