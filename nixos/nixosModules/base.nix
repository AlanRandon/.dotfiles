{ pkgs, lib, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      unstable.neovim # editor
      tree-sitter # required for neovim syntax highlighting
      github-cli # required for authentication for git
      unstable.fzf # required for tmux-sessionizer
      ripgrep # required for install-dotfiles script
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "ghostty";
      BROWSER = "firefox";
      MANPAGER = "nvim +Man!";

      # fzf catppuccin
      FZF_DEFAULT_OPTS = "\
--color=bg+:#414559,bg:#303446,spinner:#F2D5CF,hl:#E78284 \
--color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#F2D5CF \
--color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 \
--color=selected-bg:#51576D \
--color=border:#737994,label:#C6D0F5";
    };
  };

  boot.tmp.cleanOnBoot = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    keyMap = lib.mkForce "uk";
    useXkbConfig = true; # use xkb.options in tty.
  };

  users = {
    users.alan = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "%wheel"
        "dialout"
        "uinput"
      ];
      useDefaultShell = true;
      initialHashedPassword = "$y$j9T$Eyu1AFhGHTSfunmXO2G2b0$qWXs1yzrYxD1eBveUI96tqkVrb0JMmzmjFGfT/pSNrD";
      uid = 1000;
    };
    defaultUserShell = pkgs.zsh;
  };

  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  programs = {
    zsh.enable = true;
    git = {
      enable = true;
      lfs.enable = true;
    };
    tmux = {
      enable = true;
      package = pkgs.unstable.tmux;
      plugins = with pkgs.unstable.tmuxPlugins; [
        sensible
        fzf-tmux-url
      ];
      extraConfig = ''
        	set -g @plugin_catppuccin ${pkgs.unstable.tmuxPlugins.catppuccin}
      '';
    };
  };

  services = {
    udisks2.enable = true;
    kanata = {
      enable = true;
      keyboards.default.config = ''
        (defsrc
        	tab
        	caps)

        (deflayermap (default-layer)
        	tab (tap-hold 200 200 tab lmet)
        	caps (tap-hold 200 200 esc lctl))
      '';
    };
  };
}
