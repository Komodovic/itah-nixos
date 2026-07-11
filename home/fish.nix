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
      starship init fish | source
      zoxide init fish | source
      pay-respects fish | source
      alias ls="eza"
      alias cat="bat"
      abbr -a ..  'cd ..'
      abbr -a ... 'cd ../..'
      abbr -a g   git
      abbr -a gs  'git status -s'
      abbr -a ga  'git add'
      abbr -a gc  'git commit -m'
      abbr -a gp  'git push'
      abbr -a gpl 'git pull'
      abbr -a gd  'git diff'
      abbr -a nhs 'nh os switch'
      abbr -a ll  'eza -l --git'
      abbr -a la  'eza -a'
      abbr -a cheat "printf '%s\\n' '=== fish shortcuts ===' 'ls  -> eza' 'cat -> bat' 'cd  -> z (fuzzy jump)' '..  -> cd ..' '... -> cd ../..' 'g   -> git' 'gs  -> git status -s' 'ga  -> git add' 'gc  -> git commit -m' 'gp  -> git push' 'gpl -> git pull' 'gd  -> git diff' 'nhs -> nh os switch' 'll  -> eza -l --git' 'la  -> eza -a' 'cheat -> show this list'"
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
