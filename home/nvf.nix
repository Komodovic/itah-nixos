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

        -- ── Follow noctalia's live palette (regenerated on wallpaper change) ──
        -- noctalia writes its current colors to the kitty theme file; we read it
        -- and derive both the base16 colorscheme and the lualine theme from it.
        local function parse_noctalia(path)
          local f = io.open(vim.fn.expand(path))
          if not f then return nil end
          local c = {}
          for line in f:lines() do
            local k, v = line:match('^(%S+)%s+#(%x%x%x%x%x%x)')
            if k and v then
              if k:match('^color%d+$') then c[tonumber(k:sub(6))] = '#' .. v end
              if k == 'background' then c.bg = '#' .. v end
              if k == 'foreground' then c.fg = '#' .. v end
              if k == 'selection_background' then c.sel = '#' .. v end
            end
          end
          f:close()
          if c.bg and c[0] then return c end
          return nil
        end

        local function apply_noctalia()
          local c = parse_noctalia('~/.config/kitty/themes/noctalia.conf')
          if not c then return end
          local bg, fg, muted, sel = c.bg, c.fg, c[8], c.sel or c[0]
          local mauve, blue, pink = c[4], c[2], c[1]

          -- base16 palette derived from noctalia's ANSI colors
          require('base16-colorscheme').setup({
            base00 = bg,  base01 = c[0], base02 = c[8], base03 = c[8],
            base04 = c[3], base05 = fg,  base06 = fg,  base07 = fg,
            base08 = c[1], base09 = c[3], base0A = c[3], base0B = c[2],
            base0C = c[6], base0D = c[4], base0E = c[5], base0F = c[1],
          })

          -- telescope highlights follow noctalia bg/fg
          local hi = function(g, o) vim.api.nvim_set_hl(0, g, o) end
          hi('TelescopeNormal',         { fg = fg, bg = bg })
          hi('TelescopeBorder',         { fg = muted, bg = bg })
          hi('TelescopePromptNormal',   { fg = fg, bg = bg })
          hi('TelescopePromptBorder',   { fg = muted, bg = bg })
          hi('TelescopePromptPrefix',   { fg = mauve, bg = bg })
          hi('TelescopePromptCounter',  { fg = c[7], bg = bg })
          hi('TelescopePromptTitle',    { fg = bg, bg = mauve })
          hi('TelescopePreviewTitle',   { fg = bg, bg = c[5] })
          hi('TelescopeResultsTitle',   { fg = bg, bg = blue })
          hi('TelescopeSelection',      { fg = fg, bg = sel })
          hi('TelescopeSelectionCaret', { fg = mauve, bg = sel })
          hi('TelescopeMatching',       { fg = mauve, bold = true })

          -- lualine theme derived from noctalia
          require('lualine').setup({
            options = {
              theme = {
                normal   = { a = { fg = bg, bg = mauve },  b = { fg = fg, bg = sel }, c = { fg = muted, bg = bg } },
                insert   = { a = { fg = bg, bg = blue } },
                visual   = { a = { fg = bg, bg = mauve } },
                replace  = { a = { fg = bg, bg = pink } },
                command  = { a = { fg = bg, bg = mauve } },
                terminal = { a = { fg = bg, bg = mauve } },
                inactive = { a = { fg = muted, bg = sel }, b = { fg = muted, bg = sel }, c = { fg = muted, bg = bg } },
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
            extensions = { 'nvim-tree', 'nvim-dap-ui' },
          })
        end

        apply_noctalia()
        -- re-sync when returning to nvim after a wallpaper change
        vim.api.nvim_create_autocmd('FocusGained', { callback = apply_noctalia, desc = 'Sync nvim colors with noctalia' })

        -- jdtls echoes the Java LSP's `language/status` ("ServiceReady", etc.)
        -- into the message area; silence it (keep the client working otherwise).
        vim.api.nvim_create_autocmd('LspAttach', {
          desc = 'Silence jdtls language/status echo',
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.name == 'jdtls' then
              client.handlers['language/status'] = function() end
            end
          end,
        })

        -- git signs
        require('gitsigns').setup({
          signs = {
            add = { text = '│' }, change = { text = '│' },
            delete = { text = '│' }, topdelete = { text = '│' },
            changedelete = { text = '│' },
          },
          current_line_blame = false,
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
        dashboard.section.footer.val = 'noctalia · nvf · NixOS'
        alpha.setup(dashboard.opts)

        -- dap UI
        require("dapui").setup()
      '';
    };
  };
}
