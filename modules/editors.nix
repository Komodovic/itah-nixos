{ ... }: {
  flake.modules.homeManager.editors = { pkgs, ... }: {
    programs.nvf = {
      enable = true;

      settings.vim = {
        languages = {
          clang.enable = true;
          java.enable = true;
          nix.enable = true;
        };

        lsp = {
          enable = true;
          mappings = {
            goToDefinition = "gd";
            goToDeclaration = "gD";
            goToType = "<leader>D";
            listImplementations = "gi";
            listReferences = "gr";
            nextDiagnostic = "<leader>dn";
            previousDiagnostic = "<leader>dp";
            openDiagnosticFloat = "<leader>dD";
            hover = "K";
            renameSymbol = "<leader>rn";
            codeAction = "<leader>ca";
            format = "<leader>gf";
          };
        };

        autocomplete.nvim-cmp.enable = true;
        formatter.conform-nvim.enable = true;

        debugger.nvim-dap = {
          enable = true;
          presets.lldb.enable = true;
        };

        git = {
          enable = true;
          gitsigns.setupOpts.signs = {
            add = { text = "│"; };
            change = { text = "│"; };
            delete = { text = "│"; };
            topdelete = { text = "│"; };
            changedelete = { text = "│"; };
          };
        };

        telescope.enable = true;

        tabline.nvimBufferline = {
          enable = true;
          setupOpts = {
            options = {
              mode = "buffers";
              separator_style = "slant";
              show_buffer_close_icons = true;
              show_close_icon = false;
              diagnostics = "nvim_lsp";
              offsets = [{
                filetype = "NvimTree";
                text = "File Explorer";
                text_align = "left";
              }];
            };
          };
        };

        filetree.nvimTree = {
          enable = true;
          setupOpts = {
            renderer = {
              highlight_git = true;
              icons = { show = { git = true; }; };
            };
            git = { enable = true; };
            view = { width = 30; side = "left"; };
            update_focused_file = { enable = true; update_root = true; };
          };
          mappings = {
            toggle = "<leader>e";
            focus = "<leader>o";
          };
        };

        binds.whichKey = {
          enable = true;
          setupOpts.preset = "modern";
        };

        autopairs.nvim-autopairs.enable = true;
        comments.comment-nvim.enable = true;

        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers.wl-copy.enable = true;
        };

        treesitter = {
          enable = true;
          grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            nix c cpp java python rust go lua json yaml toml html css javascript
            bash markdown vim vimdoc typescript tsx
          ];
        };

        visuals.indent-blankline.enable = true;

        ui.borders = {
          enable = true;
          globalStyle = "rounded";
        };

        globals = {
          mapleader = " ";
          maplocalleader = "\\";
        };

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
          autoindent = true;
          smartindent = true;
          cursorline = true;
          ignorecase = true;
          smartcase = true;
          undofile = true;
          swapfile = false;
        };

        extraPackages = with pkgs; [
          clang-tools
          cmake
          gdb
          gcc
          jdk
          maven
          gradle
          ripgrep
          fd
        ];

        extraPlugins = {
          base16        = { package = pkgs.vimPlugins.base16-nvim; };
          jdtls         = { package = pkgs.vimPlugins.nvim-jdtls; };
          dapui         = { package = pkgs.vimPlugins.nvim-dap-ui; };
          lualine       = { package = pkgs.vimPlugins.lualine-nvim; };
          alpha         = { package = pkgs.vimPlugins.alpha-nvim; };
          luasnip       = { package = pkgs.vimPlugins.luasnip; };
          friendly      = { package = pkgs.vimPlugins.friendly-snippets; };
          flash         = { package = pkgs.vimPlugins.flash-nvim; };
          inc-rename    = { package = pkgs.vimPlugins.inc-rename-nvim; };
          todo-comments = { package = pkgs.vimPlugins.todo-comments-nvim; };
          dressing      = { package = pkgs.vimPlugins.dressing-nvim; };
        };

        luaConfigPost = builtins.readFile ./nvim/init.lua;
      };
    };
  };
}
