{ ... }: {
  flake.modules.homeManager.llm = {
    programs.fish.functions = {
      __llm_model = ''
        set -l default ~/models/Qwen2.5-Coder-3B-Instruct-Q4_K_M.gguf
        if test -f "$default"
            echo "$default"
        else
            ls ~/models/*.gguf 2>/dev/null | head -1
        end
      '';

      __llm_flags = ''
        printf '%s\n' -t 12 -c 8192 -b 2048 -fa on --mlock
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
            echo "Example: llm-download bartowski/Qwen_Qwen2.5-Coder-7B-Instruct-GGUF qwen2.5-coder-7b-instruct-q4_k_m.gguf"
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
        command nanocoder --provider local --model qwen2.5-coder-3b-instruct $argv
      '';

    };
  };
}
