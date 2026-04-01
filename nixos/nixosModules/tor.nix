{ config, lib, ... }:

let
  enabled = config.dotfiles.tor.enable;
in
{
  options.dotfiles.tor.enable = lib.mkEnableOption "Enable tor and proxychains";

  config = lib.mkIf enabled {
    services.tor = {
      enable = true;
      client.enable = true;
      torsocks.enable = false;
      settings = {
        ControlPort = 9051;
      };
    };

    programs.proxychains.enable = true;
  };
}
