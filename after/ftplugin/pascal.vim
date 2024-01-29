runtime usr/devgen.vim

let g:pascal_fpc=1
let g:pascal_delphi=1

set colorcolumn=80
set foldmethod=marker
set filetype=pascal.doxygen

colorscheme borland

set gfn=Bm437_IBM_VGA_8x14:h11:cOEM:qDRAFT

set termguicolors
set guicursor=n-v-c:block-Cursor
set guicursor=i:ver50-iCursor
set guicursor=r-n-v-c:blinkon0

highlight iCursor guifg=white guibg=green
highlight nCursor guifg=white guibg=yellow

function! AbbreviationBackspace()
    " Check if in insert mode and last character is a space
    if mode() == 'i' && getline('.')[col('.') - 1] == ' '
        " Perform backspace
        call feedkeys("\<BS>", 'n')
    endif
endfunction

iab z{ {}<Left>
iab <silent> zb begin<CR><C-d>end<Esc>O<C-R>=Eatchar(' ')<CR>
