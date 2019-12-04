set nocompatible
filetype off
set exrc

" Auto install Plug https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')

" Language Syntax Support
Plug 'pangloss/vim-javascript' "JS highlighting
Plug 'mxw/vim-jsx' "JSX syntax highlighting
Plug 'jparise/vim-graphql' "graphql syntax highlighting
Plug 'digitaltoad/vim-pug' "Pug highlighting
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Tools
Plug 'mitermayer/vim-prettier'
Plug 'jiangmiao/auto-pairs' "Autocomplete brackets.
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive' "Git tools


Plug 'mattn/emmet-vim' "A bit annoying because it takes over my Tab key
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'} "Nerdtree
Plug 'neoclide/coc.nvim', {'branch': 'release'} "autocompletion

" Themes
Plug 'ryanoasis/vim-devicons' "Icons for filetypes
Plug 'vim-airline/vim-airline' "Status bar
Plug 'vim-airline/vim-airline-themes' "Applicable themes

" All of your Plugins must be added before the following line
call plug#end()

"""""""""""""""""""""""""""""""""""""""
" General Settings, Keyboard Shortcuts 
"""""""""""""""""""""""""""""""""""""""
" swap and backup files
set backup "create backup
set backupdir=~/Documents/vimbackup "where to store backup files
set dir=~/Documents/vimbackup "where to store swap files

set timeoutlen=1000
set ttimeoutlen=0
set ttyfast
set tw=500

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o "Disable Autocommeting

"map jk to esc
:imap jk <Esc> 
nnoremap ss :update<cr> 
"remap Ctrl-p for finding files run Fzf :Files command
nnoremap <C-p> :Files<Cr>
""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOpen = 1 "Closes NerdTree when opening a file
""""""""""""""""""""""""""""""""""""""""
"Completion
""""""""""""""""""""""""""""""""""""""""
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
""""""""""""""""""""""""""""""""""""""""""
"Text, tab, indent
""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=2
set tabstop=2
set ai
set wrap
set linebreak
set number
set visualbell
set t_vb=
set title titlestring=
""""""""""""""""""""""""""""""""""""""""""""
"Prettier
""""""""""""""""""""""""""""""""""""""""""""
" Autosave
" disables autosave feature
let g:prettier#autoformat = 0

" print spaces between brackets
" Prettier default: true
let g:prettier#config#bracket_spacing = 'true'

" runs prettier on file formats
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
