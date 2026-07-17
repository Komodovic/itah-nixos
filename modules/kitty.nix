{ ... }: {
  flake.modules.homeManager.kitty = {
    xdg.configFile."kitty/kitty.conf".text = ''
font_family JetBrainsMono Nerd Font
font_size 11
allow_remote_control yes
listen_on unix:/tmp/kitty
url_style curly
open_url_with brave
mouse_action_map ctrl+left click ungrabbed mouse_selection url
include themes/noctalia.conf

# Cursor trail
cursor_trail 3
cursor_trail_decay 0.1 0.4
    '';
  };
}
