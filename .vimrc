set nocompatible
filetype off
filetype indent on
set exrc
set encoding=utf-8

" Auto install Plug https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')

" syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components', {'branch': 'main'}
Plug 'jiangmiao/auto-pairs'
Plug 'fatih/vim-go'

" Tools
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive' 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mzlogin/vim-markdown-toc'
Plug 'mattn/emmet-vim' 
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'} 
Plug 'neoclide/coc.nvim', {'branch': 'release'} 

"Themes
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons' 
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes' 

"All of your Plugins must be added before the following line
call plug#end()

""""""""""""""""""""""""""""""""""""""
" Theme
""""""""""""""""""""""""""""""""""""""
set t_ut=
syntax enable
set background=dark
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_italic=0
colorscheme gruvbox
set cursorline

"""""""""""""""""""""""""""""""""""""""
" General Settings, Keyboard Shortcuts 
"""""""""""""""""""""""""""""""""""""""
set backup "create backup
set backupcopy=yes
set backupdir=~/Documents/vimbackup "where to store backup files
set dir=~/Documents/vimbackup "where to store swap files

"for windows terminal
vmap <C-c> y:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| clip.exe <CR><CR>
" paste from buffer
map <C-v> :r ~/.vimbuffer<CR>

nnoremap <C-r> :source ~/.vimrc<Cr>

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set timeoutlen=1000
set ttimeoutlen=0
set lazyredraw
set ttyfast
set tw=500

set list
set listchars=tab:⋅\ ,trail:⋅

"map jk to esc
:imap jk <Esc> 
noremap ss :w<cr> 
"remap Ctrl-p for finding files run Fzf :Files command
nnoremap <C-p> :Files<Cr>
"tabs
noremap <C-t><up> :tabr<cr>
noremap <C-t><down> :tabl<cr>
noremap <C-t><left> :tabp<cr>
noremap <C-t><right> :tabn<cr>



"Go maps
:nnoremap <C-g> :GoRun<cr>
""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOpen = 1 "Closes NerdTree when opening a file

""""""""""""""""""""""""""""""""""""""""""
"Text, tab, indent
""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=2
set tabstop=2
set softtabstop=0
set expandtab
set smarttab
set autoindent
set smartindent
set wrap
set linebreak
set number
set visualbell
set t_vb=
set title titlestring=
set relativenumber
set rnu

""""""""""""""""""""""""""""""""""""""""""""
"Prettier
""""""""""""""""""""""""""""""""""""""""""""
" Autosave
" disables autosave feature
let g:prettier#autoformat = 0

" print spaces between brackets
" Prettier default: true
let g:prettier#config#bracket_spacing = 'true'

" single quotes
let g:prettier#config#single_quote = 'true'

" runs prettier on file formats
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

""""""""""""""""""""""""""""""""""""""""""""
" COC
""""""""""""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" Intellisense
" if hidden is not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
