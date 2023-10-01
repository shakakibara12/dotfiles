local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
  print('Done.')
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {'folke/tokyonight.nvim'},
  {'nvim-lualine/lualine.nvim'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'dev-v3',
    lazy = true,
    config = false,
  },
  -- LSP Support
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
    }
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {'L3MON4D3/LuaSnip'}
    },
  },
})

-- Set colorscheme
vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight-night')

-- LSP
local lsp = require('lsp-zero').preset({
  manage_nvim_cmp = {
  set_sources = 'lsp',
  set_basic_mappings = true,
  set_extra_mappings = false,
  use_luasnip = true,
  set_format = true,
  documentation_window = true,
  }
})

lsp.extend_cmp()

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      -- (Optional) configure lua language server
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
    end,
  }
})

vim.g.mapleader = " "

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.undodir = os.getenv("HOME") .. "/.local/share/vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
