runtime usr/devgen.vim

let g:pascal_fpc=1
let g:pascal_delphi=1

set foldmethod=marker

colorscheme borland

set gfn=Bm437_IBM_VGA_8x14:h11:cOEM:qDRAFT

" fpc
set errorformat=%f(%l\\,%c)\ %m

set termguicolors
set guicursor=n-v-c:block-Cursor
set guicursor=i:ver50-iCursor
set guicursor=r-n-v-c:blinkon0

highlight iCursor guifg=white guibg=green
highlight nCursor guifg=white guibg=yellow

iab <silent> zb begin<CR><C-D>end;<Esc>O<C-R>=Eatchar(' ')<CR>
iab <silent> zc case VALUE of<CR><C-D>end;<Esc>O<Tab><C-R>=Eatchar(' ')<CR>
"iab <silent> zc case VALUE of<CR><Tab>VAL:<C-D>end;<Esc><C-R>=Eatchar(' ')<CR>
iab <silent> ze else<CR><C-D><Tab>;<Esc><C-R>=Eatchar(' ')<CR>
iab <silent> zi if<Space>then<Left><Left><Left><Left><Left>
iab <silent> zp procedure
iab <silent> zr repeat<CR><C-D>until COND;<Esc>O<C-R>=Eatchar(' ')<CR>
iab <silent> zu uses;<Left>
iab <silent> zw while COND do<CR><C-D><Esc>O<C-R>=Eatchar(' ')<CR>
iab <silent> z{ {}<Left>

iab <silent> zfu function
iab <silent> zpr program
iab <silent> zrl readln();<Left><Left>
iab <silent> zwl writeln();<Left><Left>
