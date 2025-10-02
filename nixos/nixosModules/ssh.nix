{
  config,
  lib,
  pkgs,
  ...
}:

let
  enabled = config.dotfiles.ssh.enable;
in
{
  options.dotfiles.ssh.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable ssh";
  };

  config = lib.mkIf enabled {
    environment.systemPackages = [ pkgs.sshfs ];
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };
  };
}
