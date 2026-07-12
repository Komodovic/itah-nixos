{ ... }: {
  flake.modules.homeManager.editors = { pkgs, ... }: {
    programs.nvf = {
      enable = true;

      settings.vim = {
        languages = {
          clang.enable = true;
          java.enable = true;
        };

        lsp.enable = true;
        autocomplete.nvim-cmp.enable = true;
        formatter.conform-nvim.enable = true;

        debugger.nvim-dap = {
          enable = true;
          presets.lldb.enable = true;
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

          cmp-cmdline= { package = pkgs.vimPlugins.cmp-cmdline; };
          luasnip    = { package = pkgs.vimPlugins.luasnip; };
          friendly   = { package = pkgs.vimPlugins.friendly-snippets; };
        };

        luaConfigPost = builtins.readFile ./nvim/init.lua;
      };
    };
  };
}
