{ pkgs, ... }:

{
  programs.tmux = {
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
}
