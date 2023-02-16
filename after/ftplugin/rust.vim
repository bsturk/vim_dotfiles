runtime usr/devgen.vim

let g:ale_linters = {'rust': ['analyzer','rls','cargo'],}
let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }
let g:ale_rust_rustfmt_options = '--edition 2018'
let g:ale_rust_cargo_use_clippy = 1
let g:ale_rust_cargo_check_tests = 1 
let g:ale_rust_cargo_check_examples = 1

set cindent
set cinoptions==0

iab zi      if <CR>{<CR>}<C-O><Up><Up><C-O>f(<Right>
iab zz      {<CR>}<Up>

iab z?      //////////////////////////////////////////////////////////////////////
iab z/      ///////////////////////////////////
iab z\      /*<CR><Tab>**********************************************************<CR><CR>**********************************************************<CR><C-D>*/<Up><Up><Tab>
iab z*      /******************************************************************************/
