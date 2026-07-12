vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

  require('base16-colorscheme').setup({
    base00 = bg,  base01 = c[0], base02 = c[8], base03 = c[8],
    base04 = c[3], base05 = fg,  base06 = fg,  base07 = fg,
    base08 = c[1], base09 = c[3], base0A = c[3], base0B = c[2],
    base0C = c[6], base0D = c[4], base0E = c[5], base0F = c[1],
  })

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
      component_separators = { left = "\u{E0B0}", right = "\u{E0B2}" },
      section_separators = { left = "\u{E0B0}", right = "\u{E0B2}" },
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
vim.api.nvim_create_autocmd('FocusGained', { callback = apply_noctalia, desc = 'Sync nvim colors with noctalia' })

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✖',
      [vim.diagnostic.severity.WARN]  = '⚠',
      [vim.diagnostic.severity.INFO]  = 'ℹ',
      [vim.diagnostic.severity.HINT]  = '➤',
    },
  },
})

require('gitsigns').setup({
  signs = {
    add = { text = '│' }, change = { text = '│' },
    delete = { text = '│' }, topdelete = { text = '│' },
    changedelete = { text = '│' },
  },
  current_line_blame = false,
})

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

require('nvim-tree').setup({
  renderer = { highlight_git = true, icons = { show = { git = true } } },
  git = { enable = true },
  view = { width = 30, side = 'left' },
  update_focused_file = { enable = true, update_root = true },
})
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>o', ':NvimTreeFocus<CR>', { desc = 'Focus file explorer' })

local tb = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', tb.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', tb.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', tb.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fh', tb.help_tags, { desc = 'Help' })

require('which-key').setup({ preset = 'modern' })

local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
dashboard.section.header.val = {
  '   ███╗   ██╗██╗██╗  ██╗██╗   ██╗',
  '   ████╗  ██║██║╚██╗██╔╝╚██╗ ██╔╝',
  '   ██╔██╗ ██║██║ ╚███╔╝  ╚████╔╝ ',
  '   ██║╚██╗██║██║██╔╝ ██╗   ██║   ',
  '   ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝   ╚═╝   ',
}
dashboard.section.buttons.val = {
  dashboard.button('e', '  New file', '<cmd>enew<CR>'),
  dashboard.button('f', '󰈞  Find file', '<cmd>Telescope find_files<CR>'),
  dashboard.button('r', '󰇚  Recent files', '<cmd>Telescope oldfiles<CR>'),
  dashboard.button('g', '󰈞  Live grep', '<cmd>Telescope live_grep<CR>'),
  dashboard.button('q', '󰅚  Quit', '<cmd>qa<CR>'),
}
dashboard.section.footer.val = 'noctalia · nvf · NixOS'
alpha.setup(dashboard.opts)

require("dapui").setup()

local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer",  keyword_length = 3 },
    { name = "path" },
  }),
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "buffer" } },
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" },
  }),
})
