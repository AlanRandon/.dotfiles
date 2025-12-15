{ config, lib, ... }:

let
  enabled = config.dotfiles.printing.enable;
in
{
  options.dotfiles.printing.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable printing";
  };

  config = lib.mkIf enabled {
    services = {
      printing.enable = true;
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
  };
}
