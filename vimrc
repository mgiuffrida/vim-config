let g:is_phpstorm = has('ide') && &ide == 'PhpStorm'

" Directories
if has('win32') || has('win32unix')
  if !is_phpstorm
    let s:backup = $HOME.'/_vimbackup'
    let s:plugins_vim = $HOME.'/_plugins.vim'
  endif
else
  let s:backup = $HOME.'/.vimbackup'
  let s:plugins_vim = $HOME.'/.plugins.vim'
endif

" Environment configuration
if has('win32')
  " Assume /bin/sh refers to a POSIX "sh" on Windows. (On Linux, sh.vim will
  " resolve the actual executable used.)
  let g:is_posix = 1
endif

" Re-setting nocompatible can change other options with mysterious side effects.
if &compatible
  set nocompatible
endif

let mapleader = ","
let maplocalleader = "\\"

nnoremap <Leader>0 0w

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Jump to next merge conflict
nnoremap <Leader>m /<\{7}<CR>zt

inoremap jk <ESC>

" Quickly time out on keycodes
set timeoutlen=200

set visualbell                 " Flash the screen instead of beeping on errors
set t_vb=                      " And then disable even the flashing

" Search Options:
set hlsearch             " Highlight searches
set ignorecase smartcase " Ignore case in all-lowercase searches
set incsearch            " Incremental search (search as you type)
set showmatch            " Show matching bracket
set tagcase=match        " Respect case for tag searches

if is_phpstorm
  finish
endif


" Load Vundle plugins.
try
  :exec 'source ' . s:plugins_vim
catch
  echom v:exception
endtry

" Load extended matching plugin for %.
:runtime macros/matchit.vim

filetype plugin indent on " Enable automatic settings based on file type

" Prevents some security exploits having to do with modelines in files
set modelines=0

syntax on " Syntax highlighting

" Buffer (File) Options:
set hidden                     " Lets us close window without killing buffer
set confirm                    " Prompt to save unsaved changes when exiting
                               " Keep various histories between edits
" ! - save all-caps global variables
" ' - files with remembered markes
" / - saved search patterns
" : - saved commands 
" < - saved lines per register
" f - store file marks
" h - don't restore hlsearch
set viminfo=!,'1000,/100,:100,<500,f1,h
set history=1000               " Keep 1000 lines of command line history

set undofile
set backup
let &directory = s:backup . '/swap//,' . $HOME . '/tmp//,.'
let &undodir = s:backup . '/undo//,' . $HOME . '/tmp//,.'
let &backupdir = s:backup . '/backup//,' . $HOME . '/tmp//,.'

" Insert mode:
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
set autoindent                " Use indent from current/first line
set nolinebreak               " No soft break across words when wrapping
                              " Messes with colorcolumn

if !has('nvim')
  set pastetoggle=<F2>          " Format options don't apply when paste is set
endif

set nowrap

" Status / Command Line Options:
set wildmenu                   " Show tab completion matches
" Complete longest & start wildmenu, then cycle through matches
" I prefer starting with longest:full so the wildmenu opens,
" but I can continue typing characters to narrow down the choices
set wildmode=longest:full,full
set showcmd                    " Show partial command in status line
set laststatus=2               " Always show a status line

" Shorter on work pc (see history).
"               .----------filename
"               | .--------modified [+]/[-]
"               | | .------readonly [RO]
"               | | | .----preview [preview]
"               | | | |    .---paste mode warning
"               | | | |    |
set statusline=%F%m%r%w\ %{HasPaste()}\ %=
set statusline+=[%b]\ \ %#LineNr#\ \ %l\/%L\ :%3.3v%##
"                 |                   |   |       |
"                 |                   |   |       ^--virtual (tab-expanded) col
"                 |                   |   ^----------number of lines
"                 |                   ^--------------line number
"                 ^--------value of character under cursor

" Interface Options:
if has('win32') || has('win32unix')
  "silent! colo darkblue
else
  if $is_dark_mode == 'true'
    silent! colo industry
    set bg=dark
  else
    set bg=light
    silent! colo wildcharm
  endif
endif

function! ColorColumnHighlight()
  highlight ColorColumn ctermbg=8 ctermfg=1 guibg=Grey guifg=DarkRed
endfunc

call ColorColumnHighlight()

set number                     " Display line numbers at left of screen

" Causes huge delays over SSH with tmux
" set relativenumber             " Show line numbers relative to cursor

set mouse=a                    " Enable mouse usage (all modes) in terminals

" Keep 3 lines around cursor visible
set scrolloff=3
set sidescroll=1                " Scroll smoothly when nowrap
set display+=lastline           " Show partial last line when the line wraps

" Indentation Options:
set tabstop=8                  " A \t should look like 8 spaces. Don't change
set shiftwidth=2               " Number of spaces for indent/auto-indent
set softtabstop=2              " Number of spaces to use for Tab/BS in insert mode
set expandtab                  " Expand <Tab> with spaces in insert mode
set smarttab                   " <Tab> in front of a line inserts shiftwidth spaces

set nolist " because the trailing space drives me crazy when typing
set listchars=tab:>\ ,trail:$,extends:%,precedes:<,nbsp:+

" Text Options:
if has('multi_byte')
  set encoding=utf-8
endif


"""""""
" Maps
"""""""

" F1 to be a context sensitive keyword-under-cursor lookup
nnoremap <F1> :help <C-R><C-W><CR>

" Delete current buffer without closing the window
nnoremap <Leader>c :bp<bar>sp<bar>bn<bar>bd<CR>

" Break undo sequence before deleting characters
inoremap <C-U> <C-G>u<C-U>

" Reformat current paragraph
"nnoremap Q gqip

" Move cursor between visual lines on screen
"nnoremap <Up> gk
"nnoremap <Down> gj

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
"map Y y$

" Toggle search highlighting
"nnoremap <C-Bslash>       :set hls!<bar>:set hls?<CR>
"inoremap <C-Bslash>       <Esc>:set hls!<bar>:set hls?<CR>a

" nnoremap ; :
nnoremap <Leader>. ,
" Save and reload script
nnoremap <Leader>s :so $MYVIMRC<CR>

" Allow repetition inside of visual selection
vnoremap . :norm.<CR>

" Clear search highlighting
nnoremap <Leader><space> :noh<cr>
" Fold a tag
nnoremap <Leader>ft Vatzf
" Should sort CSS properties but doesn't: nnoremap <Leader>r ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" Reselect the text that was just pasted
nnoremap <Leader>v V`]

" Commands:
command! -nargs=* Wrap set wrap nolinebreak nolist

" Map :B to :b since I frequently mistype it.
command! -nargs=? -complete=buffer B :buffer <args>

set splitbelow splitright " Split windows below or to the right

let g:vim_indent_cont = 4

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
let &guioptions = substitute(&guioptions, "t", "", "g")

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Doesn't seem to work. `:reg .` will show removed text.
" inoremap <C-U> <C-G>u<C-U>

" Prepends the character sequence to comment out a line based on the filetype.
function! CommentLine()
  let text = getline('.')
  if text == ''
    return
  endif

  let language_comments = {
        \'c': '//',
        \'cpp': '//',
        \'java': '//',
        \'javascript': '//',
        \'python': '#',
        \'scheme': ';',
        \'sh': '#',
        \'vim': '"',
        \'winbash': ';',
        \}
  if has_key(language_comments, &filetype)
    if text =~ "^ *" . language_comments[&filetype]
      return
    endif
    :execute 'normal! I' . language_comments[&filetype] . " \<ESC>^"
  endif
endfunction

" Shortcut to comment out lines.
nnoremap <silent> <leader>/ :call CommentLine() <CR>
xnoremap <silent> <leader>/ :call CommentLine() <CR>

" Only do this part when compiled with support for autocommands.
if has('autocmd')
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrc
    autocmd!

    function! SetLocalFormatting()
      if empty(&textwidth)
        setlocal textwidth=80
      endif
      setlocal formatoptions+=c  " Insert comment leader after wrapping
      setlocal formatoptions+=r  " or hitting <Enter>
      setlocal formatoptions+=q  " Format comments with gq
      setlocal formatoptions+=l  " Insert mode won't break existing long lines
      setlocal formatoptions+=j  " Delete comment leader when joining lines
      setlocal formatoptions+=t  " Auto-wrap at textwidth
      setlocal colorcolumn=+1

      if &filetype ==? "markdown" || &filetype ==? "gitcommit"
        setlocal formatoptions+=n  " Recognize lists
        setlocal formatlistpat+=\\\|^\\*\\s*  " Treat * as bullets
      endif
    endfunction

    function! ResetHelpFormatting()
      " Help files set ft=help from modelines, which are only read after we
      " have already called SetLocalFormatting.
      if &filetype ==? "help"
        setlocal textwidth&
        setlocal colorcolumn&
        setlocal formatoptions&
      endif
    endfunction

    " Overrides for text formatting.
    autocmd BufNewFile,BufReadPost * call SetLocalFormatting()
    " Reset help after processing modelines.
    autocmd BufWinEnter * call ResetHelpFormatting()

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    " Like autochdir but better.
    autocmd BufEnter * silent! lcd %:p:h

    autocmd ColorScheme * call ColorColumnHighlight()

    autocmd InsertEnter * :set nolist
    autocmd InsertLeave * :set list

    if has('win32')
      autocmd BufNewFile D:/dev/ubuntu/* setlocal fileformat=unix
    endif

    autocmd FileType python setlocal shiftwidth=2

    autocmd BufRead,BufNewFile *.gitconfig* set filetype=gitconfig
  augroup END
else
  set autochdir
endif " has('autocmd')

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(':DiffOrig')
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" notes:
" Ctrl+[ ~= ESC
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
let g:html_indent_strict = 1

" Find possibly over-indended HTML
map <Leader>. /^\(\s*\)<[^<>]*\n\1\s\{5\}/e<CR>

" set paste: paste mode (disables formatting & abbreviations)
" toggle with <F11>
" indent by shiftwidth: <<, >>
" get help for word under cursor: :h <C-R><C-W>
"
" Split horizontally: <C-W>s, :sp {file}
" Split vertically: <C-W>v, :vs {file}
" Create new window with empty file: <C-W>n
" Create new window with empty file, vertically: :vnew
" Set noequalalways to split one window in half
" Split to position, e.g.: :topleft vsp
" Quit the other window: :1q
" Close all other windows: <C-W>o
" Move to window: <C-W>w/W
" Move to previous window: <C-W>p/P
" Rotate windows: <C-W>r/R
" Exchange windows: <C-W>x
" Vertical -> horizontal: <C-W>K, etc.
" Horizontal -> vertical: <C-W>H, etc.
"
" Show buffers: :ls
" Go to buffer 2: :b 2
" Unload buffer: :bdelete name/#

function! HasPaste()
  if &paste
    return '[PASTE MODE]  '
  en
  return ''
endfunction

" todo:
" vim-sensible:
" if has('path_extra')
"   setglobal tags-=./tags tags-=./tags; tags^=./tags;
" endif

set foldmethod=indent
set foldlevelstart=99

" look for tags in cwd, then in parent directories
" set tags=tags;

" WSL yank support
"let s:clip = '/mnt/c/Windows/System32/clip.exe'
"if executable(s:clip)
"    augroup WSLYank
"        autocmd!
"        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
"    augroup END
"endif

" neovim
if has('nvim')
  " The following line, alone, makes vim startup very slow:
  "  set clipboard^=unnamed,unnamedplus

  " But the below seems to work fine:
  let g:clipboard = {
              \   'name': 'WslClipboard',
              \   'copy': {
              \      '+': 'win32yank.exe -i --crlf',
              \      '*': 'win32yank.exe -i --crlf',
              \    },
              \   'paste': {
              \      '+': 'win32yank.exe -o --lf',
              \      '*': 'win32yank.exe -o --lf',
              \   },
              \   'cache_enabled': 0,
              \ }
endif

" Do this last (especially after setting encoding)
" set autochdir " may cause problems with scripts
