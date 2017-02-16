au FileType sh,zsh,ksh,csh                          runtime after/usr/sh.vim
au BufEnter *.sh,*.ksh,*.zsh,*.csh                  runtime after/usr/sh.vim
au BufRead  prototype                               set syntax=sh | set ft=sh | so $MYVIM/usr/sh.vim
