runtime after/usr/devgen.vim
runtime after/usr/ccom.vim

if has("mac") || has("macunix")
    runtime after/usr/xcode.vim
endif

set define=^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)

noremap <leader>hf   :call FSwitch('%', '')<CR>

iab #i      #include
iab #d      #define
iab #e      #endif
iab zb      bool
