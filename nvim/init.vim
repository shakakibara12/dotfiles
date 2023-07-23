call plug#begin()

  Plug 'nvim-lualine/lualine.nvim'
  Plug 'vimwiki/vimwiki'
  Plug 'preservim/nerdcommenter'


  " LSP Support
  Plug 'neovim/nvim-lspconfig'             " Required

  " Autocompletion Engine
  Plug 'hrsh7th/nvim-cmp'         " Required
  Plug 'hrsh7th/cmp-nvim-lsp'     " Required

  " Snippets
  Plug 'L3MON4D3/LuaSnip'             " Required

  " LSP Setup
  Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v1.x'}


  Plug 'morhetz/gruvbox'
call plug#end()

" General settings
set encoding=UTF-8 nobackup nowritebackup nocursorline splitbelow splitright wildmode=longest,list,full
" Set Indent to 4 (Change "4" to Any Integer):
set shiftwidth=4 tabstop=4 softtabstop=4 autoindent smartindent expandtab
set rnu "relative number
set noshowmode
" Turn backup off
set nobackup nowb noswapfile 
set history=500
" Set to auto read when a file is changed from the outside 
set autoread 
au FocusGained,BufEnter * checktime
set signcolumn=yes

lua <<EOF
-- "Learn the keybindings, see :help lsp-zero-keybindings
-- "Learn to configure LSP servers, see :help lsp-zero-api-showcase

local lsp = require('lsp-zero')
lsp.preset('recommended')

-- "See :help lsp-zero-preferences
lsp.set_preferences({
  set_lsp_keymaps = true, -- "set to false if you want to configure your own keybindings
  manage_nvim_cmp = true, -- "set to false if you want to configure nvim-cmp on your own
})

lsp.setup()
EOF

"key- Bindings
" <leader> = ' ' this is the default leader
let mapleader=" "
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>
" doesn't work in nvim rightnow"
command! -bang -nargs=? -complete=dir HFiles
  \ call fzf#vim#files(<q-args>, {'source': 'rg --files --hidden --color=always -g "!.git" -g "!*wine*" -g "!*proton*" '}, <bang>0)
nnoremap Q <nop>
nnoremap <UP> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
map <leader>; :HFiles<CR>

colorscheme gruvbox

"set background=dark
set termguicolors
"make transparent
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE

"vimwiki path to documents & change to markdown
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

