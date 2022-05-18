
" General {{{

set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8

language en_US

" enable true colors
set termguicolors

" enable syntax highlght
syntax enable

" show line number
set number cursorline

" command history
set history=100 

" enable mouse
set mouse=a

" allow to navigate through buffers without saving
set hidden 

" :W to sudo saving
" command W w !sudo tee % > /dev/null 

" permanent undo
set undodir=~/.vim_undo
set undofile

" }}}

" UX {{{

" keep the cusor in the middle
set scrolloff=999

" enhance search function
set ignorecase smartcase magic

" extend tab features
set expandtab 
set shiftwidth=2
set tabstop=2

" wrap settings
" set textwidth=70
" set wrapmargin=2

" left and right can now navigate throw lines
set whichwrap+=h,l,<,>,[,]

" }}}

" Key Mappings {{{

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
nnoremap <leader>h :nohlsearch<cr>

" buffer control
" new command for closing buffer but without closing window
command BD bp | sp | bn | bd
nnoremap <leader>x :BD<cr>
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

" tracing
nnoremap L <c-]>
nnoremap H <c-o>

" system clipboard
vnoremap Y "+y
nnoremap P "+p
vnoremap P "+p

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

" }}}

" Other {{{

" Abbreviations {{{

" iabbrev @@ peng.devs@gmail.com

" }}}

" FileType Autocmd {{{

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}}

" }}}

" Plugins {{{

call plug#begin()

" color theme
Plug 'morhetz/gruvbox'

" Customized status/tab bar
Plug 'itchyny/lightline.vim'

" fuzzy search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" svelte syntax highlghting
Plug 'leafOfTree/vim-svelte-plugin'

" allow comment in json
Plug 'kevinoid/vim-jsonc'

call plug#end()

" coc extentions
let g:coc_global_extensions = [
      \'coc-prettier',
      \'coc-lists',
      \'coc-git',
      \'coc-explorer',
      \'coc-eslint',
      \'coc-tsserver',
      \'coc-svelte',
      \'coc-rust-analyzer',
      \'coc-json',
      \]

" }}}

" Plugin Configs {{{

" gruvbox {{{
colorscheme gruvbox
set background=dark

" change cursor highlghting effect
hi CursorLine cterm=none ctermfg=none ctermbg=none
hi CursorLineNr cterm=none ctermfg=yellow ctermbg=none
" }}}

" lightline {{{

" always showing statusbar
set laststatus=1

" fix double status line problem
set noshowmode 

" solve mode switch jitter
set ttimeoutlen=10 

" theme settings
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [ [ 'gitstatus' ],
    \             [ 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'cocstatus', 'filetype', 'fileencoding' ] ]
    \ },
    \ 'component_function': {
    \   'gitstatus': 'GitStatus',
    \   'cocstatus': 'CocStatus',
    \ },
    \ }

function! GitStatus() abort
  let status = get(g:, 'coc_git_status', '')
  return status
endfunction

function! CocStatus() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '✘ ' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, '✔ ' . info['warning'])
  endif
  return join(msgs, ' ')
endfunction

" }}}

" fzf {{{
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>fc :Rg<cr>
" }}}

" coc.nvim {{{

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add statusline support.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Use <leader>d to show documentation in preview window.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>

" Symbol renaming.
nmap <leader>R <Plug>(coc-rename)
" goto code definition
nmap <leader>l <Plug>(coc-definition)
" file explorer
nmap <space>o <Cmd>CocCommand explorer<CR>
" diagnostic jumping
nmap <space>n <Plug>(coc-diagnostic-next)
nmap <space>N <Plug>(coc-diagnostic-prev)

" }}}

" }}}

