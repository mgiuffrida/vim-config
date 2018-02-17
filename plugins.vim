" Load Vundle plugins

" Re-setting nocompatible can change other options with mysterious side effects.
if &compatible
  set nocompatible " required for Vundle, changes lots of options
endif

filetype off  " required for Vundle

" required for Vundle
if has('win32') || has('win32unix')
  let s:bundle = $HOME.'/vimfiles/bundle'
else
  let s:bundle = $HOME.'/.vim/bundle'
endif
let &runtimepath .= ',' . s:bundle . '/Vundle.vim'

call vundle#begin(s:bundle)

Plugin 'VundleVim/Vundle.vim'  " required for Vundle
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-surround'
Plugin 'bkad/CamelCaseMotion'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'
Plugin 'mgiuffrida/CSSMinister'
Plugin 'travisjeffery/vim-help'
Plugin 'nvie/vim-flake8'  " Python syntax and indent checker
Plugin 'hynek/vim-python-pep8-indent'  " Better PEP-8 indent
Plugin 'plasticboy/vim-markdown'
Plugin 'google/vim-maktaba'
Plugin 'jceb/vim-orgmode'
Plugin 'valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'junegunn/fzf.vim'
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
