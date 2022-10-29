"Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugged')

"Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'vimwiki/vimwiki'
Plug 'preservim/nerdcommenter'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'neovim/nvim-lspconfig' "Configurations for Nvim LSP
" main one
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Themes
"Plug 'tiagovla/tokyodark.nvim'
"Plug 'morhetz/gruvbox'
"Plug 'sainnhe/everforest'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}


"List ends here. Plugins become visible to Vim after this call.
call plug#end()

"General settings
set encoding=UTF-8 nobackup nowritebackup nocursorline splitbelow splitright wildmode=longest,list,full
"Set Indent to 4 (Change "4" to Any Integer):
set shiftwidth=4 tabstop=4 softtabstop=4 autoindent smartindent expandtab
set rnu "relative number
set noshowmode
 " Turn backup off
set nobackup nowb noswapfile 
set history=500
" Set to auto read when a file is changed from the outside 
set autoread 
au FocusGained,BufEnter * checktime


lua << END
require('lualine').setup {
    options = { theme = 'catppuccin' }
}
END



"key- Bindings
" <leader> = '\' this is the default leader
" let mapleader=","
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

"Colors
let g:catppuccin_flavour = "macchiato" " latte, frappe, macchiato, mocha

lua << EOF
require("catppuccin").setup()
EOF
colorscheme catppuccin

"set background=dark
set termguicolors
"make transparent
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE

"vimwiki path to documents & change to markdown
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
