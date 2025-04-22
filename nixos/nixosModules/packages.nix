{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    inetutils
    bluetuith
    hyperfine
    unzip
    xdg-utils
    custom.mountui
    unstable.newsboat
    powertop
    networkmanagerapplet
    wasmtime
    wakeonlan
    fortune
    cowsay
    thokr
    clinfo

    # Networking
    impala

    # Git
    github-cli

    # Rust
    # NOTE: not fenix, prefer a flake for projects
    rustup
    unstable.cargo-shuttle
    unstable.cargo-binstall

    # Javascript
    nodejs

    # C
    clang

    # Assembly
    nasm

    # Python
    python312

    # Zig
    # NOTE: prefer a flake for projects
    custom.zig
    custom.zls

    # Nix
    nixfmt-rfc-style
    nixd

    # Development tools
    pkg-config
    strace
    gnumake
    autoconf
    gdb
    binaryen
    httplz

    # Profiling
    config.boot.kernelPackages.perf
    flamegraph

    # System Monitor
    # btop
    htop-vim

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
    unstable.glow
    unixtools.xxd
    unstable.yazi
    timg
    eza

    # Terminal
    unstable.alacritty # Emulator
    unstable.ghostty
    tmux # Multiplexer

    # Text editor
    unstable.neovim
    # vscode # for liveshare
    tree-sitter
    stylua

    # Image editor
    gimp

    # Sound editor
    audacity

    # Sound
    playerctl
    mpv
    pavucontrol
    pulsemixer
    pulseaudio

    # LaTeX
    unstable.tectonic
    zathura
    poppler_utils

    google-chrome
  ];
}
