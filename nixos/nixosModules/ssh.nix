{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.sshfs ];
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };
}
