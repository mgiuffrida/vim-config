filetype off
"if exists('g:loaded_pathogen')
    call pathogen#infect()
"endif
filetype plugin indent on

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Prevents some security exploits having to do with modelines in files
set modelines=0

let mapleader = ","

filetype plugin indent on " Enable automatic settings based on file type
syntax on " Enable colour syntax highlighting

" Buffer (File) Options:
set hidden                     " Edit multiple unsaved files at the same time
set confirm                    " Prompt to save unsaved changes when exiting
                               " Keep various histories between edits
set viminfo='1000,f1,<500,:100,/100,h
set undofile
set dir=~/vimswap//,.
set autochdir " may cause problems with scripts
set backup                    " Keep a backup file
set backupdir=C:/Users/Michael/vimbackup
set undodir=~/vimundo//,.

" Search Options:
set hlsearch                   " Highlight searches. See below for more.
set ignorecase                 " Do case insensitive matching...
set smartcase                  " ...except when using capital letters
set incsearch                  " Incremental search
set showmatch                  " Show matching bracket

" Insert (Edit) Options:
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set autoindent                 " Sane indenting when filetype not recognised
" set nostartofline              " Emulate typical editor navigation behaviour
set nopaste                    " Start in normal (non-paste) mode
set pastetoggle=<f11>          " Use <F11> to toggle paste modes
set linebreak                  " Soft break across words.
set textwidth=80
set formatoptions=tcrql1 "ja "n1
set colorcolumn=81

" Status / Command Line Options:
set wildmenu                   " Better commandline completion
set wildmode=longest:full,full " Expand match on first Tab complete
set showcmd                    " Show (partial) command in status line.
set laststatus=2               " Always show a status line
" set cmdheight=2                " Prevent "Press Enter" messages " Show detailed information in status line
" set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]%=[0x\%04.4B][%03v][%p%%\ line\ %l\ of\ %L]

" Interface Options:
colo darkblue
set noruler                    " Causes choppy scrolling :-(
set number                     " Display line numbers at left of screen
set relativenumber
set visualbell                 " Flash the screen instead of beeping on errors
set t_vb=                      " And then disable even the flashing
set mouse=a                    " Enable mouse usage (all modes) in terminals
" Quickly time out on keycodes
set ttimeout ttimeoutlen=200
" Keep 3 lines around cursor visible
set scrolloff=3
set history=50                  " Keep 50 lines of command line history

" Indentation Options:
set tabstop=8                  " NEVER change this!
" Change the '2' value below to your preferred indentation level
set shiftwidth=2               " Number of spaces for
set softtabstop=2              " ...each indent level
set expandtab                  " Expand <tab> with spaces in insert mode.

" Text Options:
set encoding=utf-8

set modelines=5
"""""""
" Maps
"""""""
"
" F1 to be a context sensitive keyword-under-cursor lookup
nnoremap <F2> :help <C-R><C-W><CR>

nnoremap <leader>c :bp<bar>sp<bar>bn<bar>bd<CR>

" Reformat current paragraph
"nnoremap Q gqip

" Move cursor between visual lines on screen
"nnoremap <Up> gk
"nnoremap <Down> gj

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
"map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Toggle search highlighting
"nnoremap <C-Bslash>       :set hls!<bar>:set hls?<CR>
"inoremap <C-Bslash>       <Esc>:set hls!<bar>:set hls?<CR>a

inoremap jk <ESC>

" "Fix" default regex handling.
nnoremap / /\v
vnoremap / /\v
set gdefault
" nnoremap <tab> %
" vnoremap <tab> %

" nnoremap ; :
nnoremap <leader>. ,
" Save and reload script
nnoremap <leader>s :so $MYVIMRC<CR>

" Allow repetition inside of visual selection
vnoremap . :norm.<CR>

" Clear search highlighting
nnoremap <leader><space> :noh<cr>
nnoremap <leader>0 0w
" Fold a tag
nnoremap <leader>ft Vatzf
" Should sort CSS properties but doesn't: nnoremap <leader>r ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" Reselect the text that was just pasted
nnoremap <leader>v V`]

" Commands:
command! -nargs=* Wrap set wrap linebreak nolist




" Enable these once you have a better grasp of window commands.
" nnoremap <leader>w <C-w>v<C-w>l
" 
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
" map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Doesn't seem to work. `:reg .` will show removed text.
" inoremap <C-U> <C-G>u<C-U>

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent  " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" notes:
" Ctrl+[ == ESC
" v after operator forces a motion to be linewise, or exclusive if already
" linewise.
" Toggles exclusive/inclusive on characterwise motions.
" e.g., "w" moves to the first char of the next word, but is an exclusive
" motion, so "dw" does not delete the first char of the next word; "dvw" works
" as "w" does.
" gwip is like gqip but keeps cursor at the original position
"
" Forcing how the operator works:
" o_v -> forces operator to work characterwise. If it was linewise, becomes
"        exclusive.
" o_V -> forces operator to work linewise.
" o_CTRL-V -> forces operator to work blockwise.
" Motions:
" ^ -> to the first non-blank character
" f F, t T -> forward (or till) the char
" +, - -> move up/down to the first non-blank character
" ge -> back to end of word

function! GetPath()
  let b:path = expand("%:p:h")
  let b:tilde = expand("~")
  let b:pattern = '^' . escape(b:tilde, '/\')
  return substitute(b:path, b:pattern, "~", "")
endfunction

function! GetTitle()
  return 'VIM'
endfunction

set titlestring=%t\ %M\ (%{GetPath()})\ -\ %{GetTitle()}\ (%{mode()})


" HTML indent setup
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:html_indent_strict=1


ab <// </<C-X><C-O><C-F>
