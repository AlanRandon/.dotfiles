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
    environment.systemPackages = with pkgs; [
      neomutt
      pass
      lynx
      abook
      urlscan

      # calendars
      pimsync
      khal
    ];

    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    services.gnome.gnome-keyring.enable = true;
  };
}
