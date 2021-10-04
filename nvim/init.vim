"Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugged')

Plug 'tiagovla/tokyodark.nvim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/everforest'

"List ends here. Plugins become visible to Vim after this call.
call plug#end()

"General settings
set encoding=UTF-8 nobackup nowritebackup nocursorline splitbelow splitright wildmode=longest,list,full
"Set Indent to 4 (Change "4" to Any Integer):
set shiftwidth=4 tabstop=4 softtabstop=4 autoindent smartindent expandtab
set rnu "relative number
set noshowmode

"key- Bindings
let mapleader=" "
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>
command! -bang -nargs=? -complete=dir HFiles
  \ call fzf#vim#files(<q-args>, {'source': 'rg --files --hidden -g "!.git" '}, <bang>0)
nnoremap Q <nop>
nnoremap <UP> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
map ; :HFiles<CR>

"Colors
colorscheme gruvbox
"set background=dark
set termguicolors
"make transparent
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE
