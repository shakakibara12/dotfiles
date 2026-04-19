---@diagnostic disable: undefined-global
-- always set leader first!
vim.keymap.set('n', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
-- Lazy needs it
vim.g.maplocalleader = '\\'

-- keep more context on screen while scrolling
vim.opt.scrolloff = 8
-- always draw sign column. prevents buffer moving when adding/deleting sign
vim.opt.signcolumn = 'yes'
-- sweet sweet relative line numbers
vim.opt.relativenumber = true
-- and show the absolute line number for the current line
vim.opt.number = true
-- keep current content top + left when splitting
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Disable wrap
vim.opt.wrap = false
-- Disable swap
vim.opt.swapfile = false
-- infinite undo!
-- NOTE: ends up in ~/.local/state/nvim/undo/
vim.opt.undofile = true
-- Increase undolevels
vim.opt.undolevels = 10000
-- Decent wildmenu
-- in completion, when there is more than one match,
-- list all matches, and only complete to longest common match
vim.opt.wildmode = 'list:longest'
-- when opening a file with a command (like :e),
-- don't suggest files like there:
vim.opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site,*.mkv,*.mp4'
-- tabs: go big or go home
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 8
vim.opt.tabstop = 8
vim.opt.expandtab = false
-- case-insensitive search/replace
vim.opt.ignorecase = true
-- unless uppercase in search term
vim.opt.smartcase = true
-- never ever make my terminal beep
vim.opt.vb = true
-- more useful diffs (nvim -d)
-- by ignoring whitespace
vim.opt.diffopt:append('iwhite')
-- and using a smarter algorithm
-- https://vimways.org/2018/the-power-of-diff/
-- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
-- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append('algorithm:histogram')
-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = '80'
-- except in Glorius Rust where the rule is 100 characters
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'rust',
    callback = function() vim.opt_local.colorcolumn = '100' end,
})
-- show more hidden characters
-- also, show tabs nicer
vim.opt.listchars = {
    tab = '^ ',
    nbsp = '¬',
    extends = '»',
    precedes = '«',
    trail = '•',
}

-- Set borders for all floating windows
-- Everything looks beautiful with this!
vim.o.winborder = 'rounded'

-- HOTKEYS

-- Allow copying to system clipboard using space + y
vim.keymap.set('v', '<leader>y', '"+y')


-- always center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })
-- no arrow keys --- force yourself to use the home row
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')
vim.keymap.set('i', '<up>', '<nop>')
vim.keymap.set('i', '<down>', '<nop>')
vim.keymap.set('i', '<left>', '<nop>')
vim.keymap.set('i', '<right>', '<nop>')
-- F1 is pretty close to Esc, so you probably meant Esc
vim.keymap.set('', '<F1>', '<Esc>')
vim.keymap.set('i', '<F1>', '<Esc>')

-------------------------------------------------------------------------------
---
--- Autocommands
---
-------------------------------------------------------------------------------


-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.hl.on_yank({ timeout = 100 }) end,
})

-- prevent accidental writes to buffers that shouldn't be edited
vim.api.nvim_create_autocmd('BufRead', {
    pattern = { '*.orig', '*.pacnew' },
    callback = function() vim.opt_local.readonly = true end,
})

-- help filetype detection (add as needed)
-- vim.api.nvim_create_autocmd('BufRead', { pattern = '*.ext', command = 'set filetype=someft' })

-------------------------------------------------------------------------------
---
--- Diagnostics
---
-------------------------------------------------------------------------------


-- Allow virtual text
vim.diagnostic.config({ virtual_text = true, virtual_lines = false })


-------------------------------------------------------------------------------
---
--- Configuring Plugins
---
-------------------------------------------------------------------------------


-- setup lazy plugin manager first
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out,                            'WarningMsg' },
			{ '\nPress any key to exit...' },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup({
	-- automatically check for plugin updates
	checker = { enabled = true },

	-- the colorscheme should be available when starting Neovim
	{
		'Shatur/neovim-ayu',
		lazy = false, -- no lazy, it's UI
		priority = 1000, -- load first
		config = function()
			-- load the colorscheme
			vim.cmd.colorscheme('ayu')
		end,
	},

	-- get popups for pressed key, very nice
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		opts = {},
	},

	-- auto-cd to root of git project
	{
		'notjedi/nvim-rooter.lua',
		lazy = false,
		opts = {},
	},

	{
		'ibhagwan/fzf-lua',
		-- optional for icon support
		opts = {
			-- No reverse view
			fzf_opts = {
				['--layout'] = 'default',
			},
		},
		config = function()
			local fzf_lua = require('fzf-lua')

			vim.keymap.set('n', '<leader>ff', fzf_lua.files, { desc = 'fzf-lua find files' })
			vim.keymap.set('n', '<leader>fg', fzf_lua.live_grep, { desc = 'fzf-lua live grep' })
			vim.keymap.set('n', '<leader>fb', fzf_lua.buffers, { desc = 'fzf-lua buffers' })
			vim.keymap.set('n', '<leader>fh', fzf_lua.help_tags, { desc = 'fzf-lua help tags' })
		end,
	},

	-- TODO: Checkout https://codeberg.org/andyg/leap.nvim . Looks really interesting.

	-- LSP
	-- We use mason for this, as it automatically enables the installed
	-- lsp servers, by calling vim.lsp.enable('server') on them.
	-- https://github.com/mason-org/mason-lspconfig.nvim?tab=readme-ov-file#configuration-using-lazynvim
	-- For creating individual config for lsp server see:
	-- https://vonheikemen.github.io/learn-nvim/feature/lsp-setup.html#the-lsp-directory
	{
		'mason-org/mason-lspconfig.nvim',
		opts = {
			ensure_installed = {
				'lua_ls',
				'rust_analyzer',
				'ruff',
				'stylua',
				'ty'
			},
		},
		dependencies = {
			{ 'mason-org/mason.nvim', opts = {} },
			'neovim/nvim-lspconfig',
		},
	},
	-- These are the keybindings which are created automatically through
	-- nvim lsp, v0.11+ only.
	-- grn    -> renames all references of the symbol under the cursor
	-- gra    -> shows a list of code actions available in the line under the cursor
	-- grr    -> lists all the references of the symbol under the cursor
	-- gri    -> lists all the implementations for the symbol under the cursor
	-- grt    -> jump to the definition of the type symbol under the cursor
	-- gO     -> lists all symbols in the current buffer
	-- ctrl-s -> in insert mode, displays the function signature under the cursor
	--
	-- Tree-sitter, enable manual installtion of other parsers
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		opts = {
			ensure_installed = {
				'c',
				'lua',
				'vim',
				'vimdoc',
				'query',
				'rust',
				'python'
			},
		}
	}
})
