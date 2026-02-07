{
  config,
  lib,
  pkgs,
  ...
}:

let
  enabled = config.dotfiles.bluetooth.enable;
in
{
  options.dotfiles.bluetooth.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable bluetooth";
  };

  config = lib.mkIf enabled {
    environment.systemPackages = lib.optional config.dotfiles.packages.tui.extra.enable pkgs.bluetui;

    services = {
      blueman.enable = true;
    };

    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = false;
      };
    };
  };
}
