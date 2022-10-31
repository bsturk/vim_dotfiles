runtime after/usr/devgen.vim

if has("mac") || has("macunix")
    runtime after/usr/xcode.vim
endif

set cindent
set cinoptions==0

iab zi      if <CR>{<CR>}<C-O><Up><Up><C-O>f(<Right>
iab zz      {<CR>}<Up>

iab z?      //////////////////////////////////////////////////////////////////////
iab z/      ///////////////////////////////////
iab z\      /*<CR><Tab>**********************************************************<CR><CR>**********************************************************<CR><C-D>*/<Up><Up><Tab>
iab z*      /******************************************************************************/
