runtime usr/devgen.vim

if has ("win32")
    let g:qb64dev_qb64_directory = 'g:\dev\8_bit\pc\lang\basic\qb64'
endif

set gfn=Bm437_IBM_VGA_8x14:h11:cOEM:qDRAFT
colorscheme borlandp
set termguicolors
set guicursor=n-v-c:block-Cursor
set guicursor=i:ver50-iCursor
set guicursor=r-n-v-c:blinkon0
highlight iCursor guifg=white guibg=green
highlight nCursor guifg=white guibg=yellow

nnoremap <F5> : call qb64dev#QB64CompileAndRun()<cr>
nnoremap <F11> : call qb64dev#QB64Compile()<cr>
