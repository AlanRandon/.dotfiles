{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.cifs-utils
  ];

  fileSystems."/Alan" = {
    device = "//192.168.1.101/Alan";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
      in
      [ "${automount_opts},credentials=/home/alan/smb-secrets,uid=1000,gid=100" ];
  };

  fileSystems."/Windows" =
    {
      device = "/dev/nvme0n1p3";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
    };
}