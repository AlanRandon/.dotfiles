{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-GB" "en-US" ];
    nativeMessagingHosts.packages = with pkgs; [ tridactyl-native ];
    policies =
      {
        DisablePocket = true;
        ExtensionSettings = {
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          # Tridactyl
          "tridactyl.vim@cmcaine.co.uk" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/tridactyl_vim/latest.xpi";
            installation_mode = "force_installed";
          };
          # Firefox Color
          "FirefoxColor@mozilla.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/firefox-color/latest.xpi";
            installation_mode = "force_installed";
          };
          # Stylus
          "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/styl-us/latest.xpi";
            installation_mode = "force_installed";
          };
        };
        Preferences =
          let
            value = val: { Value = val; Status = "locked"; };
          in
          {
            "browser.startup.homepage" = value "file:///home/alan/.config/newtab.html";
            "browser.newtabpage.enabled" = value false;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = value true;
            "browser.toolbars.bookmarks.visibility" = value "never";
          };
      };
  };
}
