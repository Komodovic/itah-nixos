{ ... }: {
  flake.modules.homeManager.theme = { pkgs, ... }: {
    home.pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 18;
      x11.enable = true;
    };

    gtk = {
      enable = true;
      cursorTheme = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 18;
      };
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "brave-browser.desktop";
        "x-scheme-handler/http" = "brave-browser.desktop";
        "x-scheme-handler/https" = "brave-browser.desktop";
        "x-scheme-handler/chrome" = "brave-browser.desktop";

        "image/avif" = "imv.desktop";
        "image/bmp" = "imv.desktop";
        "image/gif" = "imv.desktop";
        "image/jpeg" = "imv.desktop";
        "image/jpg" = "imv.desktop";
        "image/png" = "imv.desktop";
        "image/tiff" = "imv.desktop";
        "image/webp" = "imv.desktop";

        "video/mp4" = "mpv.desktop";
        "video/mpeg" = "mpv.desktop";
        "video/webm" = "mpv.desktop";
        "video/x-matroska" = "mpv.desktop";
        "video/quicktime" = "mpv.desktop";
        "video/x-msvideo" = "mpv.desktop";
        "audio/mpeg" = "mpv.desktop";
        "audio/wav" = "mpv.desktop";
        "audio/flac" = "mpv.desktop";
        "audio/ogg" = "mpv.desktop";

        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
        "application/epub+zip" = "org.pwmt.zathura-pdf-mupdf.desktop";

        "application/vnd.oasis.opendocument.text" = "writer.desktop";
        "application/vnd.oasis.opendocument.spreadsheet" = "calc.desktop";
        "application/vnd.oasis.opendocument.presentation" = "impress.desktop";
        "application/msword" = "writer.desktop";
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
        "application/vnd.ms-excel" = "calc.desktop";
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "calc.desktop";
        "application/vnd.ms-powerpoint" = "impress.desktop";
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "impress.desktop";

        "text/plain" = "nvim.desktop";
        "text/x-java" = "nvim.desktop";
        "text/x-python" = "nvim.desktop";
        "text/x-shellscript" = "nvim.desktop";
        "text/x-nix" = "nvim.desktop";
        "application/json" = "nvim.desktop";
        "application/xml" = "nvim.desktop";
        "text/xml" = "nvim.desktop";
        "text/x-c" = "nvim.desktop";
        "text/x-c++" = "nvim.desktop";
        "text/javascript" = "nvim.desktop";
        "text/typescript" = "nvim.desktop";
        "text/markdown" = "nvim.desktop";
        "text/yaml" = "nvim.desktop";
        "text/toml" = "nvim.desktop";
      };
    };

    home.file.".mozilla/native-messaging-hosts/tridactyl.json".source =
      "${pkgs.tridactyl-native}/lib/mozilla/native-messaging-hosts/tridactyl.json";
  };
}
