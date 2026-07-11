{ ... }: {
  programs.fish = {
    enable = true;
    shellInit = ''
      set -x QT_QPA_PLATFORMTHEME qt6ct
    '';
    loginShellInit = ''
      if test -z "$NIRI_SOCKET" -a (tty) = /dev/tty1
          systemctl --user reset-failed
          systemctl --user import-environment
          systemctl --user set-environment SHELL=(which fish)
          dbus-update-activation-environment --all 2>/dev/null
          systemctl --user --wait start niri.service
          systemctl --user start --job-mode=replace-irreversibly niri-shutdown.target 2>/dev/null
          systemctl --user unset-environment WAYLAND_DISPLAY DISPLAY XDG_SESSION_TYPE XDG_CURRENT_DESKTOP NIRI_SOCKET
      end
    '';
    interactiveShellInit = ''
    set fish_greeting
  '';
  functions = {
    y = ''
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      command yazi $argv --cwd-file="$tmp"
      if read -z cwd < "$tmp"; and test "$cwd" != "$PWD"; and test -d "$cwd"
        builtin cd -- "$cwd"
      end
      command rm -f -- "$tmp"
    '';
    };
  };
}
