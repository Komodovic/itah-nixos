{ ... }: {
  flake.modules.homeManager.llama-server = { pkgs, ... }: {
    systemd.user.services.llama-server = {
      Unit = {
        Description = "llama.cpp server (Qwen2.5-Coder-7B, Vulkan)";
        After = "graphical-session.target";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.llama-cpp-vulkan}/bin/llama-server -m %h/models/qwen2.5-coder-7b-instruct-q4_k_m.gguf --host 127.0.0.1 --port 8080 -ngl 99 -t 12 -c 8192 -b 2048 --metrics";
        Restart = "on-failure";
        RestartSec = 5;
      };
  Install = { };
    };
  };
}
