au BufEnter *.p8      set ft=pico8
au BufWinEnter *.p8   colorscheme pico8 | set ft=pico8 | set guicursor=n-v-c:block-Cursor | set guicursor=i:ver50-iCursor | set guicursor=r-n-v-c:blinkon0 | highlight iCursor guifg=white guibg=steelblue
au FileType pico8     runtime after/ftplugin/lua.vim
