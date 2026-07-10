{ ... }: {
  xdg.configFile."niri/config.kdl".text = ''
spawn-at-startup "noctalia"

window-rule {
    geometry-corner-radius 12
    clip-to-geometry true
}

input {
    keyboard {
        xkb {
            layout "us"
            variant ""
        }
    }
    touchpad {
        tap
        natural-scroll
    }
}

prefer-no-csd true

cursor {
    xcursor-theme "Bibata-Modern-Classic"
    xcursor-size 20
}

layout {
    gaps 8
}

include "noctalia.kdl"

binds {
    // ── LAUNCH ──
    Mod+Return  { spawn "kitty"; }
    Mod+Space   { spawn "noctalia" "msg" "panel-toggle" "launcher"; }
    Mod+B       { spawn "brave"; }
    Mod+E       { spawn "kitty" "-e" "yazi"; }
    Mod+V       { spawn "noctalia" "msg" "panel-toggle" "clipboard"; }
    Mod+Escape  { spawn "noctalia" "msg" "session" "lock"; }

    // ── QUICK APPS ──
    Mod+N       { spawn "noctalia" "msg" "panel-toggle" "control-center" "notifications"; }
    Mod+P       { spawn "kitty" "-e" "btop"; }
    Mod+S       { spawn "localsend"; }
    Mod+Shift+O { spawn "obs"; }
    Mod+D       { spawn "libreoffice"; }

    // ── CLOSE / QUIT ──
    Mod+Q       { close-window; }
    Mod+Shift+Q { quit; }

    // ── FOCUS NAVIGATION (vim style) ──
    Mod+H       { focus-column-left; }
    Mod+J       { focus-workspace-down; }
    Mod+K       { focus-workspace-up; }
    Mod+L       { focus-column-right; }

    Mod+Home    { focus-column-first; }
    Mod+End     { focus-column-last; }
    Mod+Tab     { focus-window-previous; }
    Mod+T       { toggle-window-floating; }
    Mod+Shift+Tab { switch-focus-between-floating-and-tiling; }

    // ── MOVE COLUMNS / WINDOWS ──
    Mod+Shift+H { move-column-left; }
    Mod+Shift+J { move-workspace-down; }
    Mod+Shift+K { move-workspace-up; }
    Mod+Shift+L { move-column-right; }

    Mod+Shift+Down  { move-window-to-workspace-down; }
    Mod+Shift+Up    { move-window-to-workspace-up; }

    // ── WINDOW STATE ──
    Mod+F       { maximize-column; }
    Mod+Shift+F { fullscreen-window; }
    Mod+R       { switch-preset-column-width; }
    Mod+Ctrl+R  { switch-preset-window-width; }
    Mod+Shift+R { switch-preset-window-height; }

    Mod+Minus       { set-column-width "-10%"; }
    Mod+Equal       { set-column-width "+10%"; }
    Mod+Shift+Minus { set-window-height "-10%"; }
    Mod+Shift+Equal { set-window-height "+10%"; }

    Mod+W       { toggle-column-tabbed-display; }
    Mod+Z       { center-column; }
    Mod+Shift+Z { center-visible-columns; }
    Mod+C       { center-window; }
    Mod+Y       { consume-or-expel-window-left; }
    Mod+M       { consume-window-into-column; }
    Mod+Ctrl+W  { consume-or-expel-window-right; }
    Mod+Ctrl+E  { expel-window-from-column; }

    // ── WORKSPACES ──
    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }
    Mod+4 { focus-workspace 4; }
    Mod+5 { focus-workspace 5; }
    Mod+6 { focus-workspace 6; }
    Mod+7 { focus-workspace 7; }
    Mod+8 { focus-workspace 8; }
    Mod+9 { focus-workspace 9; }
    Mod+0 { focus-workspace 10; }

    Mod+Shift+1 { move-column-to-workspace 1; }
    Mod+Shift+2 { move-column-to-workspace 2; }
    Mod+Shift+3 { move-column-to-workspace 3; }
    Mod+Shift+4 { move-column-to-workspace 4; }
    Mod+Shift+5 { move-column-to-workspace 5; }
    Mod+Shift+6 { move-column-to-workspace 6; }
    Mod+Shift+7 { move-column-to-workspace 7; }
    Mod+Shift+8 { move-column-to-workspace 8; }
    Mod+Shift+9 { move-column-to-workspace 9; }
    Mod+Shift+0 { move-column-to-workspace 10; }

    Mod+O       { toggle-overview; }
    Mod+A       { focus-workspace-previous; }

    // ── CONTROL CENTER ──
    Mod+Period { spawn "noctalia" "msg" "panel-toggle" "control-center"; }
    Mod+Comma   { spawn "noctalia" "msg" "settings-toggle"; }
    Mod+Shift+M { spawn "noctalia" "msg" "panel-toggle" "control-center" "media"; }
    Mod+Shift+B { spawn "noctalia" "msg" "panel-toggle" "control-center" "bluetooth"; }
    Mod+Shift+N { spawn "noctalia" "msg" "panel-toggle" "control-center" "network"; }
    Mod+Shift+P { spawn "noctalia" "msg" "panel-toggle" "control-center" "power"; }
    Mod+Ctrl+Shift+O { spawn "noctalia" "msg" "panel-toggle" "control-center" "monitor"; }
    
    Mod+Shift+E { spawn "noctalia" "msg" "panel-toggle" "control-center" "weather"; }
    Mod+Shift+Y { spawn "noctalia" "msg" "panel-toggle" "control-center" "system"; }
    Mod+Ctrl+Shift+Q { spawn "noctalia" "msg" "panel-toggle" "control-center" "audio"; }
    Mod+Ctrl+Shift+F { spawn "noctalia" "msg" "panel-toggle" "control-center" "screen-time"; }
    Mod+Ctrl+Shift+Period { spawn "noctalia" "msg" "bar-toggle" "main"; }

    // ── SCREENSHOTS ──
    Print              { spawn "noctalia" "msg" "screenshot-region"; }
    Shift+Print        { spawn "noctalia" "msg" "screenshot-fullscreen"; }
    Ctrl+Print         { screenshot-window; }

    // ── SYSTEM TOGGLES (Mod+Ctrl) ──
    Mod+Ctrl+I  { spawn "noctalia" "msg" "wifi-toggle"; }
    Mod+Ctrl+N  { spawn "noctalia" "msg" "nightlight-toggle"; }
    Mod+Ctrl+Y  { spawn "noctalia" "msg" "caffeine-toggle"; }
    Mod+G { spawn "noctalia" "msg" "notification-dnd-toggle"; }
    Mod+Ctrl+B  { spawn "noctalia" "msg" "bluetooth-toggle"; }
    Mod+Shift+W { spawn "noctalia" "msg" "panel-toggle" "wallpaper"; }
    Mod+Shift+Period { power-off-monitors; }

    // ── PANEL TOGGLES (Mod+Ctrl+Shift) ──
    Mod+Ctrl+Shift+D  { spawn "noctalia" "msg" "window-switcher"; }
    Mod+Ctrl+Shift+A  { spawn "noctalia" "msg" "panel-toggle" "tray-drawer"; }
    Mod+Ctrl+Shift+V  { spawn "noctalia" "msg" "dock-toggle"; }
    Mod+Ctrl+Shift+X  { spawn "noctalia" "msg" "desktop-widgets-toggle"; }
    Mod+Ctrl+Shift+W  { spawn "noctalia" "msg" "wallpaper-random"; }
    Mod+Ctrl+Shift+C  { spawn "noctalia" "msg" "clipboard-clear"; }
    Mod+Ctrl+Shift+G  { spawn "noctalia" "msg" "notification-clear-active"; }
    Mod+Ctrl+Shift+Z  { spawn "noctalia" "msg" "theme-mode-toggle"; }

    // ── SESSION (Mod+Ctrl+Shift) ──
    Mod+Ctrl+Shift+Backspace { spawn "noctalia" "msg" "session" "logout"; }
    Mod+Ctrl+Shift+R  { spawn "noctalia" "msg" "session" "reboot"; }
    Mod+Ctrl+Shift+S  { spawn "noctalia" "msg" "session" "shutdown"; }
    Mod+Shift+S { spawn "noctalia" "msg" "panel-toggle" "session"; }
    Mod+Ctrl+Shift+U  { spawn "noctalia" "msg" "session" "suspend"; }
    Mod+Ctrl+Shift+T  { spawn "noctalia" "msg" "session" "lock-and-suspend"; }

    // ── POWER PROFILES ──
    Mod+Ctrl+1  { spawn "noctalia" "msg" "power-set" "performance"; }
    Mod+Ctrl+2  { spawn "noctalia" "msg" "power-set" "balanced"; }
    Mod+Ctrl+3  { spawn "noctalia" "msg" "power-set" "power-saver"; }

    // ── AUDIO/MIC ──
    Mod+Ctrl+U  { spawn "noctalia" "msg" "mic-volume-up" "5"; }
    Mod+Ctrl+D  { spawn "noctalia" "msg" "mic-volume-down" "5"; }
    Mod+Ctrl+M  { spawn "noctalia" "msg" "mic-mute"; }
    Mod+Ctrl+V  { spawn "noctalia" "msg" "volume-mute"; }

    // ── MISC ──
    Mod+Slash   { show-hotkey-overlay; }
    Mod+Ctrl+G  { toggle-keyboard-shortcuts-inhibit; }
    Mod+Ctrl+T  { spawn "noctalia" "msg" "templates-apply"; }
    Mod+Ctrl+P  { power-on-monitors; }

    Mod+Shift+F23 { spawn "kitty" "-e" "opencode"; }

    // ── MEDIA KEYS ──
    XF86MonBrightnessUp   { spawn "noctalia" "msg" "brightness-up" "5"; }
    XF86MonBrightnessDown { spawn "noctalia" "msg" "brightness-down" "5"; }

    XF86AudioRaiseVolume  { spawn "noctalia" "msg" "volume-up" "5"; }
    XF86AudioLowerVolume  { spawn "noctalia" "msg" "volume-down" "5"; }
    XF86AudioMute         { spawn "noctalia" "msg" "volume-mute"; }
    XF86AudioMicMute      { spawn "noctalia" "msg" "mic-mute"; }
    XF86AudioPlay         { spawn "noctalia" "msg" "media" "toggle"; }
    XF86AudioPause        { spawn "noctalia" "msg" "media" "toggle"; }
    XF86AudioNext         { spawn "noctalia" "msg" "media" "next"; }
    XF86AudioPrev         { spawn "noctalia" "msg" "media" "previous"; }
    XF86AudioStop         { spawn "noctalia" "msg" "media" "stop"; }
}
  '';
}
