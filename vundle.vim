if &compatible
  set nocompatible " required for Vundle, changes lots of options
endif

filetype off " required for Vundle

" required for Vundle
if has('win32') || has('win32unix')
  let s:bundle = $HOME.'/vimfiles/bundle'
else
  let s:bundle = $HOME.'/.vim/bundle'
endif
let &runtimepath .= ',' . s:bundle . '/Vundle.vim'

call vundle#begin(s:bundle)

Plugin 'VundleVim/Vundle.vim' " required for Vundle
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'bkad/CamelCaseMotion'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'
Plugin 'CSSMinister'
Plugin 'travisjeffery/vim-help'
Plugin 'nvie/vim-flake8' " Python syntax and indent checker
Plugin 'hynek/vim-python-pep8-indent' " Better PEP-8 indent
Plugin 'plasticboy/vim-markdown'
Plugin 'alunny/pegjs-vim'
Plugin 'jceb/vim-orgmode'

" Plugins to consider:
"   SuperTab
"   ctrlp
"   vim-easymotion

call vundle#end() " required for Vundle

let g:vundle_success = v:true
