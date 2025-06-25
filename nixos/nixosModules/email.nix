{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    unstable.himalaya
    pass
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
