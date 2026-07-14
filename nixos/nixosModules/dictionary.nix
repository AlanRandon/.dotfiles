{
  config,
  lib,
  ...
}:

let
  enabled = config.dotfiles.dictionary.enable;
in
{
  options.dotfiles.dictionary.enable = lib.mkEnableOption "Enable dictionary" // {
    default = true;
  };

  config = lib.mkIf enabled {
    services.dictd.enable = true;
  };
}
