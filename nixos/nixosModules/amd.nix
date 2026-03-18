{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.dotfiles.amd;
in
{
  options.dotfiles.amd.enable = lib.mkEnableOption "Enable AMD";

  config = lib.mkIf cfg.enable {
    hardware = {
      amdgpu.opencl.enable = true;
      graphics = {
        enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      nvtopPackages.amd
      clinfo
    ];
  };
}
