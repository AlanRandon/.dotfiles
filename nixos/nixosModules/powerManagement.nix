{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:

let
  cfg = config.dotfiles.powerManagement;
in
{
  options.dotfiles.powerManagement.enable = lib.mkEnableOption "Enable power management";

  # TODO: remove when on used stable
  disabledModules = [ "services/hardware/tlp.nix" ];
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/hardware/tlp.nix"
  ];

  config = lib.mkIf cfg.enable {
    services = {
      tlp = {
        enable = true;
        package = pkgs.unstable.tlp;
        pd = {
          enable = true;
          package = pkgs.unstable.tlp-pd;
        };
      };
      thermald.enable = true;
    };
  };
}
