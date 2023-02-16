runtime usr/devgen.vim
runtime usr/ccom.vim
runtime usr/fsswitch.vim

set define=^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)

noremap <leader>hf   :call FSwitch('%', '')<CR>

iab #i      #include
iab #d      #define
iab #e      #endif
iab zb      bool
