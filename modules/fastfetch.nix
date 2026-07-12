{ ... }: {
  flake.modules.homeManager.fastfetch = {
    xdg.configFile."fastfetch/config.jsonc".text = ''
{
  "logo": {
    "type": "kitty",
    "source": "${./logo.png}",
    "width": 27,
    "padding": { "right": 1 }
  },
  "modules": [
    { "type": "title", "color": "magenta" },
    { "type": "os", "key": "❄️" },
    { "type": "host", "key": "💻" },
    { "type": "kernel", "key": "⚙️" },
    { "type": "uptime", "key": "⏱️" },
    { "type": "command", "shell": "sh", "key": "📅", "text": "echo \"$(( ($(date +%s) - $(stat -c %Y /)) / 86400 )) days old\"" },
    { "type": "shell", "key": "🐚" },
    { "type": "wm", "key": "🪟" },
    { "type": "terminal", "key": "🖥️" },
    { "type": "command", "key": "🎨", "shell": "sh", "text": "echo noctalia" },
    { "type": "icons", "key": "🧩" },
    { "type": "localip", "key": "🌐" },
    { "type": "cpu", "key": "🔥" },
    { "type": "gpu", "key": "🎮" },
    { "type": "memory", "key": "💾" },
    { "type": "display", "key": "📺" },
    { "type": "disk", "key": "💽" },
    { "type": "packages", "key": "📦" },
    "Break",
    { "type": "colors", "symbol": "round" }
  ]
}
    '';
  };
}
