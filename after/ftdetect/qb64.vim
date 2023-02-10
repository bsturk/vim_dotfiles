if has ("win32")
    let g:qb64dev_qb64_directory = 'g:\dev\8_bit\pc\lang\basic\qb64'
endif

au BufNewFile,BufRead,BufEnter *.qb set ft=freebasic | set gfn=Bm437_IBM_VGA_8x14:h11:cOEM:qDRAFT | colorscheme borlandp | set termguicolors | set guicursor=n-v-c:block-Cursor | set guicursor=i:ver50-iCursor | set guicursor=r-n-v-c:blinkon0 | highlight iCursor guifg=white guibg=green | highlight nCursor guifg=white guibg=yellow
au BufEnter,BufNew *.qb nnoremap <F5> : call qb64dev#QB64CompileAndRun()<cr>
au BufEnter,BufNew *.qb nnoremap <F11> : call qb64dev#QB64Compile()<cr>
