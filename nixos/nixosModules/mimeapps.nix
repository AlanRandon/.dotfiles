{ lib, ... }:

let
  genAttrsConst = keys: value: lib.attrsets.genAttrs keys (_: value);
in
{
  # fd . ~ --type f --exec xdg-mime query filetype {} \; | sort | uniq

  xdg.mime.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
    "inode/directory" = "nvim.desktop";
    "x-scheme-handler/mailto" = "neomutt.desktop";
    "image/svg+xml" = "inkview.desktop";
  }
  // (genAttrsConst [
    "text/html"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/about"
    "x-scheme-handler/unknown"
  ] "firefox.desktop")
  // (genAttrsConst [
    "image/png"
    "image/jpeg"
    "image/webp"
    "image/avif"
    "image/gif"
    "video/vnd.avi"
    "video/mp4"
    "video/mpeg"
    "video/webm"
    "video/ogg"
    "audio/mp4"
    "audio/x-mpegurl"
    "audio/x-flac"
    "audio/x-wav"
    "audio/x-opus+ogg"
    "audio/mpeg"
    "audio/ogg"
    "audio/vnd.wave"
  ] "mpv.desktop");
}
