{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.man-pages
    pkgs.man-pages-posix
    pkgs.tealdeer
  ];

  documentation = {
    dev.enable = true;
    man.generateCaches = true;
  };
}
