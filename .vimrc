let g:pathogen_disabled = []
" disable clang_complete until I have it working
call add(g:pathogen_disabled, 'clang_complete')

execute pathogen#infect()
"filetype plugin indent on

syntax on
set background=dark
set number
set ruler
set autoread
set splitright

" searching
set incsearch
set hlsearch

" always show status bar
set laststatus=2

set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set shellcmdflag=-ic

" put dot files somewhere else
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//

let mapleader = ","

" save file faster
nnoremap <leader>w :w<cr>
" open CtrlP
nnoremap <leader>p :CtrlP<cr>
" search for current visual mode selection
vnoremap // y/<c-r>"<cr>

" open .h/.m
nnoremap <leader>h :e %<.h<cr>
nnoremap <leader>m :e %<.m<cr>

" easier way to close a split (but it doesn't work)
nnoremap <C-W><C-Q> <C-W>q

nnoremap <leader>cp :let @" = expand("%:t")<cr>
nnoremap <leader>cpp :let @* = expand("%:t")<cr>

" move line up
nnoremap <leader>f ddkkp
" move line down
nnoremap <leader>d ddp

set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt

" create a new line above/below in normal mode
nmap g<C-O> O<ESC>j
nmap gO o<ESC>k

nnoremap <leader>dd :put =strftime(\"%m/%d/%y\")<enter><cr>

" formats JSON
command! FormatJSON execute '%!python -m json.tool' | w


let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
let g:clang_auto_user_options = "compile_commands.json, .clang_complete"
