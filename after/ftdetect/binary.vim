au BufReadPre *.bin,*.hex,*.exe,*.dll let &binary =1
au BufReadPost * if &binary | Vinarise
au BufWritePre * if &binary | Vinarise | endif
au BufWritePost * if &binary | Vinarise
