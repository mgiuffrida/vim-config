" Re-setting nocompatible can change other options with mysterious side effects.
if &compatible
  set nocompatible " required for Vundle, changes lots of options
endif

filetype off  " required for Vundle

" Load Vundle plugins {{{
" =======================

if has('win32') || has('win32unix')
  let s:bundle = $HOME.'/vimfiles/bundle'
else
  let s:bundle = $HOME.'/.vim/bundle'
endif
let &runtimepath .= ',' . s:bundle . '/Vundle.vim'

call vundle#begin(s:bundle)


Plugin 'VundleVim/Vundle.vim'  " required for Vundle

" Motion
Plugin 'bkad/CamelCaseMotion'

" Editing
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-surround'

" Coding
Plugin 'valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'

" File completion
Plugin 'junegunn/fzf.vim'

" Plugins
Plugin 'google/vim-maktaba'


" File types:

" Git
Plugin 'tpope/vim-fugitive'  " git wrapper
Plugin 'tpope/vim-git'  " runtime files

" HTML/CSS
Plugin 'mattn/emmet-vim'
Plugin 'mgiuffrida/CSSMinister'
Plugin 'othree/html5.vim'

" Python
Plugin 'hynek/vim-python-pep8-indent'  " Better PEP-8 indent
Plugin 'nvie/vim-flake8'  " Python syntax and indent checker

" Other
Plugin 'jceb/vim-orgmode'
Plugin 'plasticboy/vim-markdown'
Plugin 'travisjeffery/vim-help'
" Plugin 'alunny/pegjs-vim'


if $OS == 'wsl'
  Plugin 'flazz/vim-colorschemes'
endif

" Plugins to consider:
"   SuperTab
"   nerdcommenter
"   ctrlp
"   vim-easymotion

call vundle#end()  " required for Vundle

let g:vundle_success = 1

" }}}

" Configure plugins {{{
" =====================

" CSSMinister
let g:CSSMinisterCreateMappings = 0

" CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<leader>')

" org-mode
let g:org_indent = 1

" vim-abolish cheat sheet
" Abolish:
"   :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or} {despe,sepa}rat{}
" Subvert:
"   :%S/address{,es,ed,ing}/referenc{e,es,ed,ing}/g
" Coerce:
"   crs (snake_case), crm (MixedCase), crc (camelCase), cru (UPPER_CASE)

" vim-markdown
let g:vim_markdown_folding_level = 4
let g:vim_markdown_new_list_item_indent = 0
let g:markdown_fenced_languages = ["cpp", "c"]

" vim-surround cheat sheet
" Change surroundings:
"   cs"]
" Delete surroundings:
"   ds"
" Surround text object:
"   ysiw"
" Surround entire line:
"   yss"
" Visual mode:
"   S"

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_enable_diagnostic_signs = 0  " disable gutter
" whitelist .ycm_extra_conf.py for YCM
let g:ycm_extra_conf_globlist = ['~/dev/c/*/.ycm_extra_conf.py']
map <F9> :YcmCompleter FixIt<CR>

" }}}

" todo: Plugins on Windows: argtextobj, vim-javascript, vim-markdown, vim-repeat, vim-surround

augroup plugins.vim
  autocmd!
  autocmd BufNewFile,BufReadPost */plugins.vim
      \ setlocal foldmethod=marker foldlevel=0
augroup END
