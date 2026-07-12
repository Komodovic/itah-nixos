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
  };
}
