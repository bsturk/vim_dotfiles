runtime usr/devgen.vim

autocmd BufRead,BufNewFile *.hy set filetype=hy

set cinwords=print

" NOTE: vimcmdline does not support hy
let cmdline_app['hy'] = 'hy'
