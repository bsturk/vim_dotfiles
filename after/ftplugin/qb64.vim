runtime usr/devgen.vim
runtime usr/themes/borland.vim

if has ("win32")
    let g:qb64dev_qb64_directory = 'g:\dev\8_bit\pc\lang\basic\qb64'
endif

nnoremap <F5>  : call qb64dev#QB64CompileAndRun()<cr>
nnoremap <F11> : call qb64dev#QB64Compile()<cr>
