{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.unstable.tmuxPlugins; [
      sensible
    ];
    extraConfig = ''
      	set -g @plugin_catppuccin ${pkgs.unstable.tmuxPlugins.catppuccin}
    '';
  };
}
