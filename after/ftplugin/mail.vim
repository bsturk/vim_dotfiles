runtime usr/devgen.vim

set expandtab
set syntax=mail
set noautoindent 
set wm=0 
set tw=9999 
set nonumber 
set digraph 
set nolist 
set nowrap

" remove nvim's default mappings for quoting

if mapcheck('<Plug>MailQuote', 'n') != '' || mapcheck('<Plug>MailQuote', 'v') != ''
    silent! unmap  <buffer> \q
    silent! vunmap <buffer> \q
endif

" and add my mapping for quoting text in mails

nnoremap <buffer> <leader>qt <plug>MailQuote
vnoremap <buffer> <leader>qt <plug>MailQuote
