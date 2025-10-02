{ config, lib, ... }:

let
  enabled = config.dotfiles.virt-manager.enable;
in
{
  options.dotfiles.virt-manager.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable virt-manager";
  };

  config = lib.mkIf enabled {
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
  };
}
