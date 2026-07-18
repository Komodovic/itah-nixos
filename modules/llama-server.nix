{ ... }: {
  flake.modules.homeManager.llama-server = { pkgs, ... }: {
    systemd.user.services.llama-server = {
      Unit = {
        Description = "llama.cpp server (Qwen2.5-Coder-7B, CPU)";
        After = "graphical-session.target";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.llama-cpp}/bin/llama-server -m %h/models/Qwen2.5-Coder-3B-Instruct-Q4_K_M.gguf --host 127.0.0.1 --port 8080 -t 12 -c 8192 -b 2048 -fa on --mlock --metrics";
        Restart = "on-failure";
        RestartSec = 5;
      };
  Install = { };
    };
  };
}
