{ pkgs, config, ... }:

let
  options = [
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
    "user"
    "users"
    "credentials=/home/alan/smb-secrets"
    "uid=${toString config.users.users.alan.uid}"
    "gid=100"
  ];
in
{
  environment.systemPackages = [
    pkgs.cifs-utils
  ];

  fileSystems."/smb/alan" = {
    device = "//Proliant/Alan";
    fsType = "cifs";
    inherit options;
  };

  fileSystems."/smb/backup" = {
    device = "//Proliant/Backup";
    fsType = "cifs";
    inherit options;
  };
}
