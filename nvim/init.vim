"" GENERAL
" show line number
set number cursorline relativenumber
set signcolumn=number

" keep the cusor in the middle
set scrolloff=999

" permanent undo
set undodir=~/.vim_undo
set undofile

" enhance search function
set ignorecase smartcase magic

" improve tab
set expandtab 
set shiftwidth=2
set tabstop=2


"" KEYMAPS

" setting leader keys
noremap <space> <nop>
let mapleader = " "
let maplocalleader = "\\"

" quick edit .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" for somehow reason this will highlight the previous search
" result in vimrc so I have to turn off highlight after
" source command.
nnoremap <leader>sv :source $MYVIMRC<cr>:noh<cr>

" disable search highlight
nnoremap <leader>H :nohlsearch<cr>

" buffer control
" new command for closing buffer but without closing window
command! BD bp | sp | bn | bd
nnoremap <leader>x :BD<cr>
nnoremap <leader>X :bd<cr>
nnoremap <leader>j :bn<cr>
nnoremap <leader>k :bp<cr>
nnoremap <leader>` :b#<cr>

" window control
nnoremap <leader><tab> <c-w>w
nnoremap <leader>w <c-w>

" move vertically through wrap line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $
nnoremap ^ <nop>
nnoremap $ <nop>
onoremap B ^
onoremap E $
vnoremap B ^
vnoremap E $

" replay macro
nnoremap Q @
nnoremap @ <nop>

" jump to marker
nnoremap M `
nnoremap MM ``

" rolling page
nnoremap J <c-d>
nnoremap K <c-u>
vnoremap J <c-d>
vnoremap K <c-u>

" substitution
vnoremap R y/\<<c-r>0\>\(-\\|_\\|?\)\@!<cr>:%s///g<left><left>

" bracket navigation
nnoremap (( [(
nnoremap )) ])
nnoremap {{ [{
nnoremap }} ]}

" exit vim
nnoremap <leader>q :qa<cr>
nnoremap <leader>Q :qa!<cr>

" redo
nnoremap U <c-r>


" enable plugins
lua require('init')
