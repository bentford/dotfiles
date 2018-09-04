let g:pathogen_disabled = []
" disable clang_complete until I have it working
call add(g:pathogen_disabled, 'clang_complete')
" disable syntastic until I have it working
call add(g:pathogen_disabled, 'syntastic')

execute pathogen#infect()
"filetype plugin indent on
filetype plugin on

syntax on
set background=dark
set number
set ruler
set cursorline
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
nnoremap <c-w><c-q> <c-w>q

nnoremap <leader>cp :let @" = expand("%:t")<cr>
nnoremap <leader>cpp :let @* = expand("%:t")<cr>

" move line up
nnoremap <leader>f ddkkp
" move line down
nnoremap <leader>g ddp

set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt

vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^

" create a new line above/below in normal mode
nmap g<C-O> O<ESC>j
nmap gO o<ESC>k

nnoremap <leader>da :put =strftime(\"%m-%d-%y\")<cr>dEkA<esc>p

" formats JSON
command! FormatJSON execute '%!python -m json.tool' | w


let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
let g:clang_auto_user_options = "compile_commands.json, .clang_complete"

" edit your .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" source your .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" markdown shortcuts
augroup markdown
    autocmd!
    autocmd FileType markdown nnoremap <leader># I### <esc>
augroup END

" remembers last line in file
augroup misc
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
 augroup END

 nnoremap <leader>nt :NERDTreeToggle<cr>
 nnoremap <leader>nf :NERDTreeFind<cr>

nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
