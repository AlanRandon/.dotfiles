{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # LaTeX
    unstable.tectonic

    # pdf viewer
    zathura

    # pdf manipulation
    poppler_utils

    # typst
    typst
    tinymist
  ];
}
