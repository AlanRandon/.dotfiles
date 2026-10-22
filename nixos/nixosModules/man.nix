{
  pkgs,
  lib,
  config,
  ...
}:

let
  enabled = config.dotfiles.packages.tui.extra.enable;
in
{
  config = lib.mkIf enabled {
    environment.systemPackages = [
      pkgs.man-pages
      pkgs.man-pages-posix
      pkgs.tealdeer
      pkgs.git-doc
    ];

    documentation = {
      dev.enable = true;
      man.cache.enable = true;
    };
  };
}
