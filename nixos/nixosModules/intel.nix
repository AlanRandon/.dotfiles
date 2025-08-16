{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.dotfiles.intel;
in
{
  options.dotfiles.intel.enable = lib.mkEnableOption "Enable Intel";

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # these may do something?
        # intel-media-driver
        # intel-vaapi-driver
        # vaapiVdpau
        # intel-compute-runtime
        # intel-ocl
        intel-compute-runtime-legacy1
        pocl
      ];
    };

    environment.systemPackages = with pkgs; [
      nvtopPackages.intel
      clinfo
    ];
  };
}
