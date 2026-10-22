{ config, lib, ... }:

let
  virt-manager-enabled = config.dotfiles.virtualisation.virt-manager.enable;
  docker-enabled = config.dotfiles.virtualisation.docker.enable;
in
{
  options.dotfiles.virtualisation = {
    virt-manager.enable = lib.mkEnableOption "Enable virt-manager" // {
      default = true;
    };
    docker.enable = lib.mkEnableOption "Enable docker" // {
      default = true;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf docker-enabled {
      # see https://nixos.wiki/wiki/Docker
      virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
      };
    })
    (lib.mkIf virt-manager-enabled {
      programs.virt-manager.enable = true;

      users.groups.libvirtd.members = [ "alan" ];

      virtualisation.libvirtd.enable = true;

      virtualisation.spiceUSBRedirection.enable = true;

      programs.dconf = {
        enable = true;
        profiles.user.databases = [
          {
            settings = {
              "org/virt-manager/virt-manager/connections" = {
                autoconnect = [ "qemu:///system" ];
                uris = [ "qemu:///system" ];
              };
            };
            lockAll = true;
          }
        ];
      };
    })
  ];
}
