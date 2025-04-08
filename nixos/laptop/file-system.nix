{
  fileSystems."/Windows" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "uid=1000"
    ];
  };
}
