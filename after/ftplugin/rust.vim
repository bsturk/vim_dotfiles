runtime usr/devgen.vim

if has("mac") || has("macunix")
    runtime usr/xcode.vim
endif

let g:ale_linters = {'rust': ['analyzer','rls','cargo'],}
let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }

set cindent
set cinoptions==0

iab zi      if <CR>{<CR>}<C-O><Up><Up><C-O>f(<Right>
iab zz      {<CR>}<Up>

iab z?      //////////////////////////////////////////////////////////////////////
iab z/      ///////////////////////////////////
iab z\      /*<CR><Tab>**********************************************************<CR><CR>**********************************************************<CR><C-D>*/<Up><Up><Tab>
iab z*      /******************************************************************************/
