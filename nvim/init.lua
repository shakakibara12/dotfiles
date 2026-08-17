---@diagnostic disable: undefined-global
-- always set leader first!
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
-- Lazy needs it
vim.g.maplocalleader = "\\"

-- keep more context on screen while scrolling
vim.opt.scrolloff = 8
-- always draw sign column. prevents buffer moving when adding/deleting sign
vim.opt.signcolumn = "yes"
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
vim.opt.wildmode = "list:longest"
-- prevent the built-in vim.lsp.completion autotrigger from selecting the first item
vim.opt.completeopt = { "menuone", "noselect", "popup" }
-- when opening a file with a command (like :e),
-- don't suggest files like there:
vim.opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site,*.mkv,*.mp4"
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
vim.opt.diffopt:append("iwhite")
-- and using a smarter algorithm
vim.opt.diffopt:append("algorithm:histogram")
-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = "80"
-- except in Glorius Rust where the rule is 100 characters
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		vim.opt_local.colorcolumn = "100"
	end,
})
-- show more hidden characters and nicer tabs
vim.opt.listchars = {
	tab = "^ ",
	nbsp = "¬",
	extends = "»",
	precedes = "«",
	trail = "•",
}

-- Set borders for all floating windows
-- Everything looks beautiful with this!
vim.opt.winborder = "rounded"
-- Rounded popups
vim.opt.pumborder = "rounded"
-- Max items shown at once
vim.opt.pumheight = 15
-- Min width of the popup
vim.opt.pumwidth = 40
-- Slight transparency
vim.opt.pumblend = 10
-- Transparency for floating docs
vim.opt.winblend = 10

-- HOTKEYS
-- Allow copying to system clipboard using space + y
vim.keymap.set("v", "<leader>y", '"+y')
-- always center search results
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "*", "*zz", { silent = true })
vim.keymap.set("n", "#", "#zz", { silent = true })
vim.keymap.set("n", "g*", "g*zz", { silent = true })
-- no arrow keys --- force yourself to use the home row
vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("n", "<left>", "<nop>")
vim.keymap.set("n", "<right>", "<nop>")
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")
-- F1 is pretty close to Esc, so you probably meant Esc
vim.keymap.set("", "<F1>", "<Esc>")
vim.keymap.set("i", "<F1>", "<Esc>")

-- Auto-cd to the current file's parent directory.
vim.keymap.set("n", "<leader>cd", "<CMD>cd %:p:h<CR><CMD>pwd<CR>")

-- Update using pack
vim.keymap.set("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>")

-------------------------------------------------------------------------------
---
--- Autocommands
---
-------------------------------------------------------------------------------

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ timeout = 100 })
	end,
})

-- Prevent accidental writes to buffers that shouldn't be edited
vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.orig", "*.pacnew" },
	callback = function()
		vim.opt_local.readonly = true
	end,
})

-- Auto format using lsp before save.
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = true })
	end,
})

-- I just like wraps in markdown
vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*.md" },
	callback = function()
		vim.opt.wrap = true
	end,
})

-------------------------------------------------------------------------------
---
--- Configuring Plugins
---
-------------------------------------------------------------------------------

-- Setup vim.pack
-- NOTE: plugin updates is done manually via :lua vim.pack.update()
-- Or use <leader>ps

-- stylua: ignore
local gh = function(x) return "https://github.com/" .. x end
-- stylua: ignore
local cb = function(x) return "https://codeberg.org/" .. x end

vim.pack.add({
	gh("Shatur/neovim-ayu"),
	gh("nvim-lualine/lualine.nvim"),
	gh("folke/which-key.nvim"),
	gh("notjedi/nvim-rooter.lua"),
	gh("ibhagwan/fzf-lua"),
	gh("mason-org/mason.nvim"),
	gh("mason-org/mason-lspconfig.nvim"),
	gh("neovim/nvim-lspconfig"),
	gh("nvim-treesitter/nvim-treesitter"),
	gh("lervag/wiki.vim"),
	gh("MeanderingProgrammer/render-markdown.nvim"),
	cb("andyg/leap.nvim"),
	gh("mrcjkb/rustaceanvim"),
	gh("ellisonleao/gruvbox.nvim"),
	gh("rose-pine/neovim"),
})

-- the colorscheme should be available when starting Neovim
-- load the colorscheme
vim.cmd.colorscheme("ayu")

-- load the status bar
require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "ayu",
	},
})
-- no need to also show mode in cmd line when we have bar
vim.opt.showmode = false

-- get popups for pressed key, very nice
require("which-key").setup()

-- auto-cd to root of git project
require("nvim-rooter").setup()

-- Setup fzf-lua
local fzf_lua = require("fzf-lua")
fzf_lua.setup({
	-- No reverse view
	fzf_opts = {
		["--layout"] = "default",
	},
})

vim.keymap.set("n", "<leader>ff", fzf_lua.files, { desc = "fzf-lua find files" })
vim.keymap.set("n", "<leader>fg", fzf_lua.live_grep, { desc = "fzf-lua live grep" })
vim.keymap.set("n", "<leader>fb", fzf_lua.buffers, { desc = "fzf-lua buffers" })
vim.keymap.set("n", "<leader>fh", fzf_lua.help_tags, { desc = "fzf-lua help tags" })
-- Setup wiki.nvim
vim.g.wiki_root = "~/Documents/notes"
vim.g.wiki_select_method = {
	pages = require("wiki.fzf_lua").pages,
	tags = require("wiki.fzf_lua").tags,
	toc = require("wiki.fzf_lua").toc,
	links = require("wiki.fzf_lua").links,
}

-- Leap out of those bounderies!
vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
vim.keymap.set("n", "S", "<Plug>(leap-from-window)")


-- Setup LSP
-- We use mason for this, as it automatically enables the installed
-- lsp servers, by calling vim.lsp.enable('server') on them.
-- https://github.com/mason-org/mason-lspconfig.nvim?tab=readme-ov-file#configuration-using-lazynvim
-- For creating individual config for lsp server see:
-- https://vonheikemen.github.io/learn-nvim/feature/lsp-setup.html#the-lsp-directory
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"ruff",
		"stylua",
		"ty",
	},
})

-- vim.diagnostic.config({ virtual_text = true })

-- LSP keybindings
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Tree-sitter, enable manual installation of other parsers
require("nvim-treesitter").install({
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"rust",
	"python",
	"markdown",
	"markdown_inline",
})

-- Don't show "match 1 of 3" messages in command line
vim.opt.shortmess:append("c")

-- buffer local keybindings, better performance?
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
		map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
		map("n", "gr", vim.lsp.buf.references, "References")
		map("n", "gt", vim.lsp.buf.type_definition, "type definition")
		map("n", "gk", vim.lsp.buf.signature_help, "signature help")
		map("n", "grn", vim.lsp.buf.rename, "Rename symbol")
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
	end,
})
