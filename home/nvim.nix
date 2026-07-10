{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    # ── System tools wrapped into Neovim's PATH (no Mason needed) ──
    extraPackages = with pkgs; [
      clang-tools # clangd, clang-format, clang-tidy
      cmake
      gdb
      gcc
      jdk # java/javac — required for the JVM that runs jdtls
      maven
      gradle
      ripgrep
      fd
    ];

    # ── Treesitter (installs all grammars, incl. c/cpp/java) ──
    plugins.treesitter.enable = true;

    # ── LSP ──
    plugins.lsp = {
      enable = true;
      servers.clangd.enable = true;
    };

    # ── Completion ──
    plugins.cmp.enable = true;

    # ── Formatting (clang-format for C/C++) ──
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          cpp = [ "clangformat" ];
          c = [ "clangformat" ];
        };
      };
    };

    # ── Debugging (nvim-dap) ──
    plugins.dap.enable = true;

    # ── Extra Lua plugins (NixVim options don't cover these directly) ──
    extraPlugins = with pkgs.vimPlugins; [
      base16-nvim # matugen/base16 theme
      nvim-jdtls # Java LSP
      nvim-dap-ui # DAP UI
    ];

    # ── Everything not covered by the options above, as raw Lua ──
    extraConfigLua = ''
      -- ── matugen / base16 custom theme (mauve palette) ──
      require('base16-colorscheme').setup({
        base00 = '#181115', base01 = '#251e21', base02 = '#30282b',
        base03 = '#9f8c94', base04 = '#d6c1c9', base05 = '#eddfe3',
        base06 = '#eddfe3', base07 = '#eddfe3', base08 = '#ffb4ab',
        base09 = '#ffb5a0', base0A = '#eab9d1', base0B = '#ffaed9',
        base0C = '#ffb5a0', base0D = '#ffaed9', base0E = '#eab9d1',
        base0F = '#93000a',
      })
      local hi = function(g, o) vim.api.nvim_set_hl(0, g, o) end
      hi('TelescopeNormal',         { fg = '#eddfe3', bg = '#181115' })
      hi('TelescopeBorder',         { fg = '#9f8c94', bg = '#181115' })
      hi('TelescopePromptNormal',   { fg = '#eddfe3', bg = '#181115' })
      hi('TelescopePromptBorder',   { fg = '#9f8c94', bg = '#181115' })
      hi('TelescopePromptPrefix',   { fg = '#ffaed9', bg = '#181115' })
      hi('TelescopePromptCounter',  { fg = '#d6c1c9', bg = '#181115' })
      hi('TelescopePromptTitle',    { fg = '#181115', bg = '#ffaed9' })
      hi('TelescopePreviewTitle',   { fg = '#181115', bg = '#eab9d1' })
      hi('TelescopeResultsTitle',   { fg = '#181115', bg = '#ffb5a0' })
      hi('TelescopeSelection',      { fg = '#eddfe3', bg = '#30282b' })
      hi('TelescopeSelectionCaret', { fg = '#ffaed9', bg = '#30282b' })
      hi('TelescopeMatching',       { fg = '#ffaed9', bold = true })

      -- ── DAP: codelldb adapter + C/C++ launch configs ──
      local dap = require("dap")
      dap.adapters.codelldb = {
        type = "server",
        port = "''${port}",
        executable = {
          command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb",
          args = { "--port", "''${port}" },
        },
      }
      local get_exe = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = get_exe,
          cwd = "''${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp

      require("dapui").setup()

      -- ── Java LSP via packaged jdtls (Nix-pure, no runtime download) ──
      local jdtls = require("jdtls")
      local launcher = vim.fn.glob("${pkgs.jdt-language-server}/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
      local jdtls_config = "${pkgs.jdt-language-server}/share/java/jdtls/config_linux"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          jdtls.start_or_attach({
            cmd = {
              "java",
              "-jar", launcher,
              "-configuration", jdtls_config,
              "-data", vim.fn.stdpath("data") .. "/jdtls",
            },
            root_dir = jdtls.setup.find_root({ ".git", "build.gradle", "pom.xml" }),
            init_options = { bundles = {} },
          })
        end,
      })
    '';
  };
}
