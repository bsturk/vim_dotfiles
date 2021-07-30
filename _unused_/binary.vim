au BufReadPre *.bin,*.hex,*.exe,*.dll setlocal binary
au BufReadPost * if &binary | call eval( printf("<SNR>%d_HEX_Manager()", GetScriptNumber("hexman.vim") ) ) | endif
au BufWritePre * if &binary | call eval( printf("<SNR>%d_HEX_Manager()", GetScriptNumber("hexman.vim") ) ) | endif
