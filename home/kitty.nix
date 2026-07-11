{ ... }: {
  xdg.configFile."kitty/kitty.conf".text = ''
font_family JetBrainsMono Nerd Font
font_size 11
allow_remote_control yes
listen_on unix:/tmp/kitty
include themes/noctalia.conf
  '';
}
