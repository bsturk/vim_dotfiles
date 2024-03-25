" this prevents vim from treating the file as a binary due to ATASCII, etc
au BufReadPre *.fb setlocal nobinary ff=dos
au BufRead,BufNewFile *.fb set ft=fastbasic
let g:netrw_fastbrowse = 0
