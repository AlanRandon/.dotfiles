# UNUSED: use mangowc if lightweight compositor is desired

{ dwl, ... }:

(dwl.override {
  configH = ./config.h;
}).overrideAttrs
  {
    patches = [
      ./patches/focusdir.patch
      ./patches/autostart-0.7.patch
    ];
  }
