" Note: Some options, like t_vb, need to be set in both $HOME/.vimrc and
" $HOME/.gvimrc because they are reset when the GUI is started.
set t_vb=                      " Disable screen flash on error
function! GetTitle()
  return 'GVIM'
endfunction

if has('win32') || has('win32unix')
  set guifont=Consolas:h11
  set lines=40
endif

let &numberwidth = float2nr(log10(line("$"))) + 3
    \| let &columns = &numberwidth + 80

