runtime usr/devgen.vim

set cindent
set cinoptions=

iab zi      if <CR>{<CR>}<C-O><Up><Up><C-O>f(<Right>
iab zz      {<CR>}<Up><C-R>=Eatchar(' ')<CR>

iab z?      //////////////////////////////////////////////////////////////////////
iab z/      ///////////////////////////////////
iab z\      /*<CR><Tab>**********************************************************<CR><CR>**********************************************************<CR><C-D>*/<Up><Up><Tab>
iab z*      /******************************************************************************/


setlocal omnifunc=v:lua.vim.lsp.omnifunc
nnoremap <buffer><silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <buffer><silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <buffer><silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <buffer><silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <buffer><silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap<buffer> <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <buffer><silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <buffer><silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <buffer><silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

setlocal signcolumn=yes  "prevent text shifting with lsp errors
setlocal completeopt=menu,noinsert,noselect,menuone
