{
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
}
