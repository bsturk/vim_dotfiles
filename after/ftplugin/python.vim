runtime usr/devgen.vim

iab zc class_name_:<C-O>b<C-O>f_
iab zd def_func_name_( args ):<C-O>4b<C-O>f_
iab ze else:<C-O>h<C-O>a
iab zE elif:<C-O>h<C-O>a
iab zf for_foo_ in _bar_:<C-O>3b<C-O>f_
iab zF from_foo_ import *<C-O>3b<C-O>f_
iab zh ################################################################################<CR>#<CR># file:     xxx.py<CR>#<CR># purpose:<CR>#<CR># author:   brian m sturk   bsturk@briansturk.com<CR>#                           http://briansturk.com<CR>#<CR># created:  ??/??/??<CR># last_mod: ??/??/??<CR># version:  0.1<CR>#<CR># usage:      <CR>#<CR># history:<CR>#<CR>################################################################################
iab zi if:<C-O>h<C-O>a
iab zI import
iab zp print
iab zt try:<C-O>h<C-O>a
iab z* ################################################################################
iab z/ #############

let g:slime_python_ipython = 1

"  python.vim macro overrides

set wildignore+=*.pyc
set expandtab

nmap  <leader>vb   [[V]]
nmap  <leader>vc   :call PythonSelectObject("class")<CR>
nmap  <leader>vf   :call PythonSelectObject("function")<CR>

nmap ]c :call PythonDec("class", 1)<CR>
nmap [c :call PythonDec("class", -1)<CR>
nmap ]f :call PythonDec("function", 1)<CR>
nmap [f :call PythonDec("function", -1)<CR>
map  ]k  :call PythonNextLine(-1)<CR>
map  ]j  :call PythonNextLine(1)<CR>

set cinwords=class,def,elif,else,except,finally,for,if,try,while
