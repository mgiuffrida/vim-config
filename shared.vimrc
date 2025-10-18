let mapleader = ","
let maplocalleader = "\\"

set visualbell                 " Flash the screen instead of beeping on errors
set t_vb=                      " And then disable even the flashing

" Quickly time out on keycodes
set timeoutlen=200

" Keep 3 lines around cursor visible
set scrolloff=3

" Search Options:
set hlsearch             " Highlight searches
set ignorecase smartcase " Ignore case in all-lowercase searches
set incsearch            " Incremental search (search as you type)
set showmatch            " Show matching bracket
set tagcase=match        " Respect case for tag searches

nnoremap <Leader>0 ^

" Disable automatic clipboard sync
set clipboard=

" Map <leader>y/p to yank/paste to/from system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" Convert dot property access to bracket access
nnoremap <leader>.[ s['<Esc>/\W<CR>i']<Esc>:nohl<CR>

" Converts JSDoc @param annotations to a single object parameter
noremap <leader>jo :s/@param {\(.*\)} \(.*\)$/\2: \1,/<CR>:nohl<CR>
