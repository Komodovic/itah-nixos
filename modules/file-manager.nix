{ ... }: {
  flake.modules.homeManager.file-manager = {
    xdg.configFile."yazi/yazi.toml".text = ''
      [opener]
      edit = [
        { run = 'nvim "$@"', block = true },
      ]
      open = [
        { run = 'xdg-open "$@"', desktop = true, mimetype = "image/*" },
        { run = 'xdg-open "$@"', desktop = true, mimetype = "video/*" },
        { run = 'xdg-open "$@"', desktop = true, mimetype = "audio/*" },
        { run = 'xdg-open "$@"', desktop = true, mimetype = "application/pdf" },
        { run = 'nvim "$@"', block = true },
      ]
    '';

    xdg.configFile."yazi/keymap.toml".text = ''
      [mgr]
      prepend_keymap = [
        { on = [ "c", "a" ], run = "plugin compress", desc = "Compress selection" },
      ]
    '';

    xdg.configFile."yazi/theme.toml".text = ''
      [flavor]
      dark = "noctalia"
      light = "noctalia"
    '';
  };
}
