{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;

    settings.vim = {
      # ── Language presets: treesitter + LSP + formatter, auto-wired ──
      languages = {
        clang.enable = true; # C/C++: clangd + clang-format + treesitter
        java.enable = true;  # Java: treesitter + jdtls (nvf preset, read-only safe)
      };

      lsp.enable = true;
      autocomplete.nvim-cmp.enable = true;   # completion
      formatter.conform-nvim.enable = true;  # formatting (clang-format for C/C++)

      # ── Debugging (nvim-dap + codelldb, nvf-native) ──
      debugger.nvim-dap = {
        enable = true;
        presets.lldb.enable = true;
      };

      # ── System tools on nvim's PATH ──
      extraPackages = with pkgs; [
        clang-tools # clangd, clang-format, clang-tidy
        cmake
        gdb
        gcc
        jdk # java/javac — jdtls wrapper uses its own JDK, but handy on PATH
        maven
        gradle
        ripgrep
        fd
      ];

      # ── Extra Lua plugins (made available on runtimepath) ──
      lazy.plugins = {
        base16-nvim = { package = pkgs.vimPlugins.base16-nvim; };
        nvim-jdtls = { package = pkgs.vimPlugins.nvim-jdtls; };
        nvim-dap-ui = { package = pkgs.vimPlugins.nvim-dap-ui; };
      };

      # ── Raw Lua: matugen/base16 theme + DAP UI ──
      luaConfigPost = ''
        -- matugen / base16 custom theme (mauve palette)
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

        require("dapui").setup()
      '';
    };
  };
}
