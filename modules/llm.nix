{ ... }: {
  flake.modules.homeManager.llm = {
    programs.fish.functions = {
      __llm_model = ''
        set -l default ~/models/qwen2.5-coder-7b-instruct-q4_k_m.gguf
        if test -f "$default"
            echo "$default"
        else
            ls ~/models/*.gguf 2>/dev/null | head -1
        end
      '';

      __llm_flags = ''
        echo -ngl 99 -t 6 -c 16384 -b 2048 -ub 512 -ctk q8_0 -ctv q8_0 -fa on
      '';

      llm = ''
        set MODEL (__llm_model)
        if test -z "$MODEL"
            echo "No GGUF model found in ~/models"
            echo "Download one with: llm-download <hf-repo> <filename>"
            return 1
        end
        echo "Using: $MODEL"
        llama-cli -m "$MODEL" (__llm_flags) --color on --temp 0.6 --repeat-penalty 1.1 $argv
      '';

      llm-server = ''
        set MODEL (__llm_model)
        if test -z "$MODEL"
            echo "No GGUF model found in ~/models"
            return 1
        end
        echo "Starting server with: $MODEL"
        echo "API at http://localhost:8080"
        llama-server -m "$MODEL" (__llm_flags) --jinja --port 8080 --host 127.0.0.1 $argv
      '';

      llm-prompt = ''
        if test (count $argv) -eq 0
            echo "Usage: llm-prompt <prompt text>"
            return 1
        end
        llm --prompt "$argv"
      '';

      llm-download = ''
        if test (count $argv) -lt 2
            echo "Usage: llm-download <hf-repo> <filename>"
            echo "Example: llm-download bartowski/Qwen_Qwen3-4B-Instruct-2507-GGUF Qwen_Qwen3-4B-Instruct-2507-Q4_K_M.gguf"
            return 1
        end
        set REPO $argv[1]
        set FILENAME $argv[2]
        set URL "https://huggingface.co/$REPO/resolve/main/$FILENAME"
        set OUT ~/models/$FILENAME
        echo "Downloading: $URL"
        echo "To: $OUT"
        curl -L -o "$OUT" "$URL"
      '';

      nanocoder = ''
        nanocoder --provider local --model qwen2.5-coder-7b-instruct $argv
      '';

      nanocoder-serve = ''
        set MODEL (__llm_model)
        if test -z "$MODEL"
            echo "No GGUF model found in ~/models"
            return 1
        end
        echo "Starting nanocoder server with: $MODEL"
        llama-server -m "$MODEL" (__llm_flags) --jinja --port 8080 --host 127.0.0.1 $argv
      '';

    };
  };
}
