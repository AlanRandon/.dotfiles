{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neomutt
    pass
    lynx
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
