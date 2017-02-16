au BufReadPre *.bin,*.hex,*.exe,*.dll setlocal binary
au BufReadPost * if &binary | call HEX_Manager() | endif
