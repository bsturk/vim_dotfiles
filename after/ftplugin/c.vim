runtime usr/devgen.vim
runtime usr/ccom.vim

let g:ale_c_parse_makefile = 1
" could not get the C/C++ linter to grok my directory structure
"let g:ale_c_gcc_options="-Iengine"
"let g:ale_cpp_gcc_options="-Iengine"

let g:ale_cpp_ccls_init_options = {
\   'cache': {
\       'directory': '/tmp/ccls/cache'
\   }
\ }

call extend(g:ale_linters, { 'cpp': ['gcc'], 'c': ['gcc'] })
call extend(g:ale_linters_ignore, { 'cpp': ['gcc'], 'c': ['gcc'] })

set define=^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)

noremap <leader>hf   :call FSwitch('%', '')<CR>

iab #i      #include
iab #d      #define
iab #e      #endif
iab zb      bool
