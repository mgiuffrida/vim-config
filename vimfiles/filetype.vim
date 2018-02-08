" gn file
"if exists("did_load_filetypes")
"  finish
"endif
"augroup filetypedetect
"  au! BufRead,BufNewFile *.gn setfiletype gn
"augroup END
