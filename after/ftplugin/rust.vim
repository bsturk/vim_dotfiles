runtime usr/devgen.vim

set cindent
set cinoptions=

iab za      assert!();<C-O>2h
iab zd      dbg!();<C-O>2h
iab ze      else {<CR>}<Up><End><CR>
iab zE      else if {<CR>}<Up><End><C-O>F{<Left><Left>
iab zf      for {<CR>}<Up><End><C-O>F{<Left><Left>
iab zi      if {<CR>}<Up><End><C-O>F{<Left><Left>
iab zl      loop {<CR>}<Up><End><CR>
iab zm      match {<CR>_ => {},<CR>}<Up><Up><End><C-O>F{<Left><Left>
iab zp      pub
iab zr      return;<Left>
iab zt      // TODO:
iab zw      while {<CR>}<Up><End><C-O>F{<Left><Left>
iab zz      {<CR>}<Up><C-R>=Eatchar(' ')<CR>

iab z?      //////////////////////////////////////////////////////////////////////
iab z/      ///////////////////////////////////
iab z\      /*<CR><Tab>**********************************************************<CR><CR>**********************************************************<CR><C-D>*/<Up><Up><Tab>
iab z*      /******************************************************************************/

setlocal makeprg=cargo\ check\ --message-format=short
setlocal errorformat=%f:%l:%c:\ %t%*[^:]:\ %m,%f:%l:%c:\ %m
setlocal omnifunc=v:lua.vim.lsp.omnifunc
setlocal signcolumn=yes  "prevent text shifting with lsp errors
setlocal completeopt=menu,noinsert,noselect,menuone

nnoremap <buffer><silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <buffer><silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <buffer><silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <buffer><silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <buffer><silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap<buffer> <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <buffer><silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <buffer><silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <buffer><silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
