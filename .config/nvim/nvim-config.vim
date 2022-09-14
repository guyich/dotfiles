set nocompatible
set scrolloff=10 "number of context lines you would like to see above and below the cursor
set number
set rnu "[number]G jump to absolute line number
set mouse=a

filetype off
filetype indent on
set exrc
set encoding=utf-8
set laststatus=2
set t_Co=256
""""""""""""""""""""""""""""""""""""""""""
"Text, tab, indent
""""""""""""""""""""""""""""""""""""""""""
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smartindent

set wrap
set linebreak
set visualbell
set t_vb=
set title titlestring=

call plug#begin('~/.vim/plugged')

" syntax highlighting
"Plug 'pangloss/vim-javascript'
"Plug 'leafgarland/typescript-vim'
"Plug 'jiangmiao/auto-pairs'

" Tools
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
"Plug 'tomtom/tcomment_vim'
"Plug 'tpope/vim-fugitive' 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mzlogin/vim-markdown-toc'
"Plug 'mattn/emmet-vim' 
Plug 'fatih/vim-go'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'vimwiki/vimwiki'
Plug 'yuttie/comfortable-motion.vim'


"Themes
Plug 'gruvbox-community/gruvbox'

"All of your Plugins must be added before the following line
call plug#end()

let g:vimwiki_list = [{   'path': '~/Documents/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_listsyms = '✗○◐●✓'
au FileType vimwiki setlocal shiftwidth=6 tabstop=6 noexpandtab
nmap <Leader>d <Plug>VimwikiToggleListItem

""""""""""""""""""""""""""""""""""""""
" Theme
""""""""""""""""""""""""""""""""""""""
set t_ut=
syntax enable
set background=dark
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox
set cursorline
highlight QuickFixLine ctermbg=NONE ctermfg=white cterm=bold guibg=NONE gui=bold

"""""""""""""""""""""""""""""""""""""""
" General Settings, Keyboard Shortcuts 
"""""""""""""""""""""""""""""""""""""""
if empty(glob('~/Documents/vimbackup'))
  silent !mkdir ~/Documents/vimbackup
endif
"set backup "create backup
"set backupcopy=yes
set nobackup
set nowritebackup
set backupdir=~/Documents/vimbackup "where to store backup files
set dir=~/Documents/vimbackup "where to store swap files

"For Windows Terminal
"vmap <C-c> y:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| clip.exe <CR><CR>
" paste from buffer
"map <C-v> :r ~/.vimbuffer<CR>

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set timeoutlen=1000
set ttimeoutlen=0
set lazyredraw
set ttyfast
set tw=500


"""""""""""""""""""""""""""""""""""""""
" Remaps
"""""""""""""""""""""""""""""""""""""""

let mapleader = " "

" Fzf and Telesope
nnoremap <C-p> :GFiles<Cr> 
nnoremap <leader>pf <cmd>Telescope find_files<CR>
nnoremap <leader>b <cmd>Telescope buffers<CR>
nnoremap <leader>gr <cmd>Telescope live_grep<CR>
nnoremap <leader>th <cmd>Telescope help_tags<CR>

" Source vimrc
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
" Open vimrc
nnoremap <leader>ov :e ~/.config/nvim/init.vim<CR>

" Split verticaly
nnoremap <leader>vs :vs
" Split horizontaly
nnoremap <leader>sp :sp

"tabs
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

"scrolling
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
nnoremap <silent> <C-d> :call comfortable_motion#flick(200)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-200)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(200)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(-200)<CR>

"""""""""""""""""""""""""""""""""""""""
" Go remaps
"""""""""""""""""""""""""""""""""""""""
nnoremap <C-g> :GoRun<cr>

""""""""""""""""""""""""""""""""""""""""""""
" COC
""""""""""""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Intellisense
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
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
" Remap for format selected region
 vmap <leader>f  <Plug>(coc-format-selected)
 nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
 nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
 nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
 nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
 nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
 nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
 nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
 nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
 nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

 "vim-go config
 "disable vim-go :GoDef (gd)
 "this is handled by languageClient
 let g:go_def_mapping_enabled=0
