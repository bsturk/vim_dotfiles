runtime usr/devgen.vim
runtime usr/themes/borland.vim

let g:pascal_fpc=1
let g:pascal_delphi=1

set foldmethod=marker

" fpc
set errorformat=%f(%l\\,%c)\ %m

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
