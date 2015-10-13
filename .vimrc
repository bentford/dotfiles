execute pathogen#infect()
"filetype plugin indent on

syntax on
set background=dark
set number
set ruler
set autoread

vnoremap // y/<c-r>"<cr>

" easier way to close a split (but it doesn't work)
nnoremap <C-W><C-Q> <C-W>q

set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>


" create a new line above/below in normal mode
nmap g<C-O> O<ESC>j
nmap gO o<ESC>k

" formats JSON
command! FormatJSON execute '%!python -m json.tool' | w

set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set shellcmdflag=-ic
