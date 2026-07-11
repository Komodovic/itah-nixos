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

      # ── Debugging (nvim-dap + lldb-dap, nvf-native) ──
      debugger.nvim-dap = {
        enable = true;
        presets.lldb.enable = true;
      };

      # ── Editor feel (LazyVim-like) ──
      options = {
        number = true;
        relativenumber = true;
        signcolumn = "yes";
        termguicolors = true;
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        scrolloff = 8;
        wrapscan = true;
        showmode = false;
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

      # ── Extra Lua plugins (made available on runtimepath + set up) ──
      # extraPlugins uses a free-form attrsOf, so names never collide with
      # nvf's built-in reserved plugin slots (unlike lazy.plugins).
      extraPlugins = {
        base16     = { package = pkgs.vimPlugins.base16-nvim; };
        jdtls      = { package = pkgs.vimPlugins.nvim-jdtls; };
        dapui      = { package = pkgs.vimPlugins.nvim-dap-ui; };
        lualine    = { package = pkgs.vimPlugins.lualine-nvim; };
        bufferline = { package = pkgs.vimPlugins.bufferline-nvim; };
        nvimtree   = { package = pkgs.vimPlugins.nvim-tree-lua; };
        whichkey   = { package = pkgs.vimPlugins.which-key-nvim; };
        telescope  = { package = pkgs.vimPlugins.telescope-nvim; };
        plenary    = { package = pkgs.vimPlugins.plenary-nvim; };
        alpha      = { package = pkgs.vimPlugins.alpha-nvim; };
        gitsigns   = { package = pkgs.vimPlugins.gitsigns-nvim; };
        devicons   = { package = pkgs.vimPlugins.nvim-web-devicons; };
      };

      # ── Raw Lua: LazyVim-ish look (mauve palette) ──
      luaConfigPost = ''
        vim.g.mapleader = " "
        vim.g.maplocalleader = "\\"

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

        -- git signs
        require('gitsigns').setup({
          signs = {
            add = { text = '│' }, change = { text = '│' },
            delete = { text = '│' }, topdelete = { text = '│' },
            changedelete = { text = '│' },
          },
          current_line_blame = false,
        })

        -- lualine (LazyVim-ish): mode | file | branch | diagnostics | lsp
        -- Custom theme built from the mauve base16 palette so we don't depend
        -- on a base16 colors_name being set (which avoids the config warning).
        local C = {
          bg = '#181115', fg = '#eddfe3', muted = '#9f8c94',
          panel = '#30282b', accent = '#ffaed9', accent2 = '#eab9d1',
          red = '#ffb4ab',
        }
        require('lualine').setup({
          options = {
            theme = {
              normal   = { a = { fg = C.bg, bg = C.accent },  b = { fg = C.fg, bg = C.panel }, c = { fg = C.muted, bg = C.bg } },
              insert   = { a = { fg = C.bg, bg = C.accent2 } },
              visual   = { a = { fg = C.bg, bg = C.accent2 } },
              replace  = { a = { fg = C.bg, bg = C.red } },
              command  = { a = { fg = C.bg, bg = C.accent } },
              terminal = { a = { fg = C.bg, bg = C.accent } },
              inactive = { a = { fg = C.muted, bg = C.panel }, b = { fg = C.muted, bg = C.panel }, c = { fg = C.muted, bg = C.bg } },
            },
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            icons_enabled = true,
          },
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { { 'filename', path = 1 } },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
          extensions = { 'nvim-tree', 'telescope', 'dapui' },
        })

        -- bufferline (top tabline of buffers, like LazyVim)
        require('bufferline').setup({
          options = {
            mode = 'buffers',
            separator_style = 'slant',
            show_buffer_close_icons = true,
            show_close_icon = false,
            diagnostics = 'nvim_lsp',
            offsets = { { filetype = 'NvimTree', text = 'File Explorer', text_align = 'left' } },
          },
        })

        -- nvim-tree file explorer
        require('nvim-tree').setup({
          renderer = { highlight_git = true, icons = { show = { git = true } } },
          git = { enable = true },
          view = { width = 30, side = 'left' },
          update_focused_file = { enable = true, update_root = true },
        })
        vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
        vim.keymap.set('n', '<leader>o', ':NvimTreeFocus<CR>', { desc = 'Focus file explorer' })

        -- telescope
        local tb = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', tb.find_files, { desc = 'Find files' })
        vim.keymap.set('n', '<leader>fg', tb.live_grep, { desc = 'Live grep' })
        vim.keymap.set('n', '<leader>fb', tb.buffers, { desc = 'Buffers' })
        vim.keymap.set('n', '<leader>fh', tb.help_tags, { desc = 'Help' })

        -- which-key (auto-collects descriptions from keymaps)
        require('which-key').setup({ preset = 'modern' })

        -- alpha dashboard (LazyVim-style start screen)
        local alpha = require('alpha')
        local dashboard = require('alpha.themes.dashboard')
        dashboard.section.header.val = {
          '   ███╗   ██╗██╗██╗  ██╗██╗   ██╗',
          '   ████╗  ██║██║╚██╗██╔╝╚██╗ ██╔╝',
          '   ██╔██╗ ██║██║ ╚███╔╝  ╚████╔╝ ',
          '   ██║╚██╗██║██║ ██╔██╗   ╚██╔╝  ',
          '   ██║ ╚████║██║██╔╝ ██╗   ██║   ',
          '   ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝   ╚═╝   ',
        }
        dashboard.section.buttons.val = {
          dashboard.button('e', '  New file', '<cmd>enew<CR>'),
          dashboard.button('f', '󰈞  Find file', '<cmd>Telescope find_files<CR>'),
          dashboard.button('r', '󰇚  Recent files', '<cmd>Telescope oldfiles<CR>'),
          dashboard.button('g', '󰈞  Live grep', '<cmd>Telescope live_grep<CR>'),
          dashboard.button('q', '󰅚  Quit', '<cmd>qa<CR>'),
        }
        dashboard.section.footer.val = 'mauve · nvf · NixOS'
        alpha.setup(dashboard.opts)

        -- dap UI
        require("dapui").setup()
      '';
    };
  };
}
