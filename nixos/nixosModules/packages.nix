{
  pkgs,
  lib,
  config,
  ...
}:

let

  mkEnableOptionTrue =
    description:
    lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = description;
    };

  basePackages = with pkgs; [
    tmux # Multiplexer
    unstable.fzf
    jq
    github-cli
    ripgrep # `grep`-like
    unstable.neovim
    tree-sitter
    networkmanagerapplet
    unstable.ghostty
    pulseaudio
  ];

  defaultExtraCliPackages = with pkgs; [
    ffmpeg
    poppler_utils
    playerctl
    yt-dlp
    httplz
    strace
    inetutils
    hyperfine
    unzip
    xdg-utils
    wakeonlan
    fortune
    cowsay
    lsof
    tree
    figlet
    clolcat
    bc
    wget
    dig
    unixtools.xxd
    zoxide # `cd`-like
    bat # `cat`-like
    eza # `ls`-like
    fd # `find`-like
    dysk # `df`-like
    du-dust # `du`-like
  ];

  defaultExtraTuiPackages = with pkgs; [
    pulsemixer
    gdb
    bluetuith
    custom.mountui
    unstable.newsboat
    powertop
    thokr
    starship
    htop-vim
    unstable.glow
    unstable.yazi
    impala
    timg
  ];

  defaultExtraGuiPackages = with pkgs; [
    zathura
    pavucontrol
    unstable.alacritty
    unstable.mcpelauncher-ui-qt
    unstable.gimp3
    audacity
    (mpv.override { scripts = [ mpvScripts.mpris ]; })
    google-chrome
  ];

  defaultExtraDevPackages = with pkgs; [
    clang
    nasm
    pkg-config
    gnumake
    autoconf
    flamegraph
    config.boot.kernelPackages.perf
  ];

  defaultLanguagePackages = {
    zig = {
      packages = with pkgs; [ custom.zig ];
      lspPackages = with pkgs; [ custom.zls ];
    };
    rust = {
      packages = with pkgs; [
        rustup
        unstable.cargo-shuttle
        unstable.cargo-binstall
      ];
      lspPackages = [ ];
    };
    web = {
      packages = with pkgs; [
        nodejs
        wasmtime
        binaryen
      ];
      lspPackages = with pkgs; [
        vscode-langservers-extracted
        tailwindcss-language-server
        typescript-language-server
        emmet-ls
      ];
    };
    python = {
      packages = with pkgs; [
        python312
        ruff
      ];
      lspPackages = with pkgs; [ pyright ];
    };
    nix = {
      packages = with pkgs; [ nixfmt-rfc-style ];
      lspPackages = with pkgs; [ nixd ];
    };
    lua = {
      packages = with pkgs; [ stylua ];
      lspPackages = with pkgs; [ lua-language-server ];
    };
    toml = {
      packages = [ ];
      lspPackages = with pkgs; [ taplo ];
    };
    latex = {
      packages = with pkgs; [ unstable.tectonic ];
      lspPackages = with pkgs; [ texlab ];
    };
    typst = {
      packages = with pkgs; [
        typst
        typstyle
      ];
      lspPackages = with pkgs; [
        tinymist
      ];
    };
  };

  mkExtraPackagesOption = name: defaultPackages: {
    enable = mkEnableOptionTrue "Enable additional ${name} packages";
    packages = lib.mkOption {
      type = with lib.types; listOf package;
      default = defaultPackages;
      description = "Extra ${name} packages";
    };
  };

  mkLanguageOption =
    {
      name,
      defaultPackages,
      defaultLspPackages,
    }:
    {
      enable = mkEnableOptionTrue "Enable ${name}";
      packages = lib.mkOption {
        type = with lib.types; listOf package;
        default = defaultPackages;
        description = "Packages for ${name}";
      };
      lspPackages = lib.mkOption {
        type = with lib.types; listOf package;
        default = defaultLspPackages;
        description = "LSP packages for ${name}";
      };
    };

  cfg = config.dotfiles.packages;

in
{
  options.dotfiles.packages = {
    languages = lib.attrsets.mapAttrs (
      name:
      { packages, lspPackages }:
      mkLanguageOption {
        name = name;
        defaultPackages = packages;
        defaultLspPackages = lspPackages;
      }
    ) defaultLanguagePackages;
    cli.extra = mkExtraPackagesOption "CLI" defaultExtraCliPackages;
    tui.extra = mkExtraPackagesOption "TUI" defaultExtraTuiPackages;
    gui.extra = mkExtraPackagesOption "GUI" defaultExtraGuiPackages;
    lsp.enable = mkEnableOptionTrue "Enable LSP packages";
    dev.extra = mkExtraPackagesOption "build and debug tools" defaultExtraDevPackages;
  };

  config = lib.mkMerge [
    {
      environment.systemPackages =
        basePackages
        ++ lib.optionals cfg.cli.extra.enable cfg.cli.extra.packages
        ++ lib.optionals cfg.tui.extra.enable cfg.tui.extra.packages
        ++ lib.optionals cfg.gui.extra.enable cfg.gui.extra.packages
        ++ lib.optionals cfg.dev.extra.enable cfg.dev.extra.packages
        ++ (lib.concatLists (
          lib.attrsets.mapAttrsToList (
            _: lang:
            (lib.optionals lang.enable (lang.packages ++ (lib.optionals cfg.lsp.enable lang.lspPackages)))
          ) cfg.languages
        ));
    }
  ];
}
